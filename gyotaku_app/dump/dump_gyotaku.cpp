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
#include <unistd.h>
#include <dump/pixel_dump.h>
#include <android-base/file.h>

#define GYOTAKU_DIRECTORY "/data/vendor/gyotaku/andlog"
#define GYOTAKU_ANDROID_LOG_PREFIX "android_"
#define GYOTAKU_ODPM_LOG_PREFIX "odpm_"
#define maxFileLogsNumber 30

int main() {
    std::string outputDir = concatenatePath(BUGREPORT_PACKING_DIR, "gyotaku");
    if (mkdir(outputDir.c_str(), 0700) == -1) {
        printf("Unable to create folder: %s\n", outputDir.c_str());
        return 0;
    }

    dumpLogs(GYOTAKU_DIRECTORY, outputDir.c_str(), maxFileLogsNumber, GYOTAKU_ANDROID_LOG_PREFIX);
    dumpLogs(GYOTAKU_DIRECTORY, outputDir.c_str(), maxFileLogsNumber, GYOTAKU_ODPM_LOG_PREFIX);
    return 0;
}

