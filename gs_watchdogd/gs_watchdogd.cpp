/*
 * Copyright (C) 2022 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <android-base/chrono_utils.h>
#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/stringprintf.h>
#include <android-base/unique_fd.h>
#include <log/log.h>

#include <fcntl.h>
#include <glob.h>
#include <linux/watchdog.h>
#include <stdlib.h>
#include <string.h>
#include <sys/cdefs.h>
#include <unistd.h>

#include <cstdlib>
#include <vector>

#define NSEC_PER_SEC (1000LL * 1000LL * 1000LL)

#define DEV_GLOB "/sys/devices/platform/*.watchdog_cl*/watchdog/watchdog*"

using android::base::Basename;
using android::base::StringPrintf;

int main(int __unused argc, char** argv) {
    auto min_timeout_nsecs = std::numeric_limits<typeof(NSEC_PER_SEC)>::max();

    android::base::InitLogging(argv, &android::base::KernelLogger);

    glob_t globbuf;
    int ret = glob(DEV_GLOB, GLOB_MARK, nullptr, &globbuf);
    if (ret) {
        PLOG(ERROR) << "Failed to lookup glob " << DEV_GLOB << ": " << ret;
        return 1;
    }

    std::vector<android::base::unique_fd> wdt_dev_fds;

    for (size_t i = 0; i < globbuf.gl_pathc; i++) {
        int timeout_secs;
        std::string dev_path = StringPrintf("/dev/%s", Basename(globbuf.gl_pathv[i]).c_str());

        int fd = TEMP_FAILURE_RETRY(open(dev_path.c_str(), O_RDWR | O_CLOEXEC));
        if (fd == -1) {
            PLOG(ERROR) << "Failed to open " << dev_path;
            return 1;
        }

        ret = ioctl(fd, WDIOC_GETTIMEOUT, &timeout_secs);
        if (ret) {
            PLOG(ERROR) << "Failed to get timeout on " << dev_path;
            continue;
        } else {
            min_timeout_nsecs = std::min(min_timeout_nsecs, NSEC_PER_SEC * timeout_secs);
        }

        wdt_dev_fds.emplace_back(fd);
    }

    globfree(&globbuf);

    if (wdt_dev_fds.empty()) {
        LOG(ERROR) << "no valid wdt dev found";
        return 1;
    }

    timespec ts;
    auto result = div(min_timeout_nsecs / 2, NSEC_PER_SEC);
    ts.tv_sec = result.quot;
    ts.tv_nsec = result.rem;

    while (true) {
        timespec rem = ts;

        for (const auto& fd : wdt_dev_fds) {
            TEMP_FAILURE_RETRY(write(fd, "", 1));
        }

        if (TEMP_FAILURE_RETRY(nanosleep(&rem, &rem))) {
            PLOG(ERROR) << "nanosleep failed";
            return 1;
        }
    }
}
