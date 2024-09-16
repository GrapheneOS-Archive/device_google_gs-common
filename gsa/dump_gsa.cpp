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
#include <dump/pixel_dump.h>
#include <unistd.h>

#define DIM(arr) (sizeof(arr) / sizeof(arr[0]))

const char* paths[][2] = {{"GSA MAIN LOG", "/dev/gsa-log1"},
                          {"GSA INTERMEDIATE LOG", "/dev/gsa-bl1-log2"}};

int main() {
  for (size_t i = 0; i < DIM(paths); i++) {
    if (!access(paths[i][1], R_OK)) {
      dumpFileContent(paths[i][0], paths[i][1]);
    }
  }
  return 0;
}
