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

#include <errno.h>
#include <fcntl.h>
#include <glob.h>
#include <linux/watchdog.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <chrono>
#include <vector>

#define DEV_GLOB "/sys/devices/platform/*.watchdog_cl*/watchdog/watchdog*"

#define DEFAULT_INTERVAL 10s
#define DEFAULT_MARGIN 10s

using android::base::Basename;
using android::base::StringPrintf;
using std::literals::chrono_literals::operator""s;

int main(int argc, char** argv) {
    android::base::InitLogging(argv, &android::base::KernelLogger);

    std::chrono::seconds interval = argc >= 2
        ? std::chrono::seconds(atoi(argv[1])) : DEFAULT_INTERVAL;
    std::chrono::seconds margin = argc >= 3
        ? std::chrono::seconds(atoi(argv[2])) : DEFAULT_MARGIN;

    LOG(INFO) << "gs_watchdogd started (interval " << interval.count()
              << ", margin " << margin.count() << ")!";

    glob_t globbuf;
    int ret = glob(DEV_GLOB, GLOB_MARK, nullptr, &globbuf);
    if (ret) {
        PLOG(ERROR) << "Failed to lookup glob " << DEV_GLOB << ": " << ret;
        return 1;
    }

    std::vector<android::base::unique_fd> wdt_dev_fds;

    for (size_t i = 0; i < globbuf.gl_pathc; i++) {
        std::chrono::seconds timeout = interval + margin;
        int timeout_secs = timeout.count();
        std::string dev_path = StringPrintf("/dev/%s", Basename(globbuf.gl_pathv[i]).c_str());

        int fd = TEMP_FAILURE_RETRY(open(dev_path.c_str(), O_RDWR | O_CLOEXEC));
        if (fd == -1) {
            PLOG(ERROR) << "Failed to open " << dev_path;
            return 1;
        }

        wdt_dev_fds.emplace_back(fd);
        ret = ioctl(fd, WDIOC_SETTIMEOUT, &timeout_secs);
        if (ret) {
            PLOG(ERROR) << "Failed to set timeout to " << timeout_secs;
            ret = ioctl(fd, WDIOC_GETTIMEOUT, &timeout_secs);
            if (ret) {
                PLOG(ERROR) << "Failed to get timeout";
            } else {
                interval = timeout > margin ? timeout - margin : 1s;
                LOG(WARNING) << "Adjusted interval to timeout returned by driver: "
                             << "timeout " << timeout_secs
                             << ", interval " << interval.count()
                             << ", margin " << margin.count();
            }
        }
    }

    globfree(&globbuf);

    while (true) {
        for (const auto& fd : wdt_dev_fds) {
            TEMP_FAILURE_RETRY(write(fd, "", 1));
        }
        sleep(interval.count());
    }
}
