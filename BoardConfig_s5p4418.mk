#
# Copyright (C) 2015 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include device/nexell/con_svma/BoardConfigCommon.mk

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a9

# misc by-name path
NEXELL_MISC_PARTITION := /dev/block/platform/c0000000.soc/c0062000.dwmmc/by-name/misc

BOARD_CAMERA_BACK_DEVICE := "7"
BOARD_CAMERA_BACK_ORIENTATION := "0"
BOARD_CAMERA_NUM := 1
BOARD_CAMERA_USE_ZOOM := false
BOARD_CAMERA_SUPPORT_SCALING := true
