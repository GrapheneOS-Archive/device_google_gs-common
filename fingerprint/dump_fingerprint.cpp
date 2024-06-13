/*
 * Copyright 2024 The Android Open Source Project
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
#include <android-base/file.h>
#include <dump/pixel_dump.h>
#include <log/log.h>
#include <stdio.h>
#include <string.h>

static constexpr const char *kTombstonesDirPath = "/data/vendor/tombstones/fingerprint/";

int main() {
    printf("------ Fingerprint tombstones ------\n");
    std::unique_ptr<DIR, decltype(&closedir)> tombstones_dir(opendir(kTombstonesDirPath), closedir);
    if (tombstones_dir) {
        dirent *entry;
        while ((entry = readdir(tombstones_dir.get())) != nullptr) {
            std::string file_name(entry->d_name);
            if (!strcmp(file_name.c_str(), ".") || !strcmp(file_name.c_str(), ".."))
                continue;
            std::string file_path(kTombstonesDirPath + file_name);
            dumpFileContent(file_name.c_str(), file_path.c_str());
        }
    }

    return 0;
}
