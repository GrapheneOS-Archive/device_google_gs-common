/*
 ** Copyright 2024, The Android Open Source Project
 **
 ** Licensed under the Apache License, Version 2.0 (the "License");
 ** you may not use this file except in compliance with the License.
 ** You may obtain a copy of the License at
 **
 **     http://www.apache.org/licenses/LICENSE-2.0
 **
 ** Unless required by applicable law or agreed to in writing, software
 ** distributed under the License is distributed on an "AS IS" BASIS,
 ** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ** See the License for the specific language governing permissions and
 ** limitations under the License.
 */
#define LOG_TAG "touch_gti_ical"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#ifdef __ANDROID__
#include <cutils/properties.h>
#include <cutils/log.h>
#else
#define property_set
#define property_get
#define ALOGI printf
#define ALOGW printf
#endif

int main(int argc, char *argv[])
{
	char *line = NULL;
	size_t len = 0;
	FILE *ical_fd;
	const char *ical_state_prop[2] = {
		[0] = "vendor.touch.gti0.ical.state",
		[1] = "vendor.touch.gti1.ical.state",
	};
	const char *ical_result_prop[2] = {
		[0] = "vendor.touch.gti0.ical.result",
		[1] = "vendor.touch.gti1.ical.result",
	};
	const char *ical_sysfs[2] = {
		[0] = "/sys/devices/virtual/goog_touch_interface/gti.0/interactive_calibrate",
		[1] = "/sys/devices/virtual/goog_touch_interface/gti.1/interactive_calibrate",
	};
	const char *ical_state_prop_path = ical_state_prop[0];
	const char *ical_result_prop_path = ical_result_prop[0];
	const char *ical_sysfs_path = ical_sysfs[0];

	if (argc < 3) {
		ALOGW("No target dev or command for interactive_calibrate sysfs.\n");
		property_set(ical_state_prop[0], "done");
		property_set(ical_state_prop[1], "done");
		return 0;
	}

	if (strncmp(argv[1], "1", strlen(argv[1])) == 0 ||
		strncmp(argv[1], "gti1", strlen(argv[1])) == 0 ||
		strncmp(argv[1], "gti.1", strlen(argv[1])) == 0) {
		ical_state_prop_path = ical_state_prop[1];
		ical_result_prop_path = ical_result_prop[1];
		ical_sysfs_path = ical_sysfs[1];
	}

	property_set(ical_result_prop_path, "na");
	property_set(ical_state_prop_path, "running");
	if (access(ical_sysfs_path, F_OK | R_OK | W_OK)) {
		ALOGW("Can't access %s\n", ical_sysfs_path);
		property_set(ical_state_prop_path, "done");
		return 0;
	}

	ical_fd = fopen(ical_sysfs_path, "r+");
	if (ical_fd == NULL) {
		ALOGW("Can't fopen %s\n", ical_sysfs_path);
		property_set(ical_state_prop_path, "done");
		return 0;
	}

	if (strncmp(argv[2], "read", strlen(argv[2])) == 0) {
		getline(&line, &len, ical_fd);
		if (line != NULL) {
			property_set(ical_state_prop_path, "read");
			property_set(ical_result_prop_path, line);
			ALOGI("read: %s => %s", ical_sysfs_path, line);
			free(line);
		}
	} else {
		property_set(ical_state_prop_path, argv[2]);
		fwrite(argv[2], 1, strlen(argv[2]), ical_fd);
		ALOGI("write: %s => %s\n", argv[2], ical_sysfs_path);
	}
	property_set(ical_state_prop_path, "done");

	fclose(ical_fd);
	return 0;
}

