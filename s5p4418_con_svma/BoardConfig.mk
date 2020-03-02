#
# Copyright 2017 The Android Open-Source Project
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

-include device/nexell/con_svma/common/BoardConfigCommon.mk

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a9

# misc by-name path
NEXELL_MISC_PARTITION := /dev/block/by-name/misc

# bluetooth
BOARD_CUSTOM_BT_CONFIG := device/nexell/con_svma/s5p4418_con_svma/bluetooth_config/vnd_con_svma_s5p4418.txt


# Kernel & DTB Setting
ifneq ($(QUICKBOOT), 1)
TARGET_KERNEL_DEFCONFIG := s5p4418_con_svma_pie_defconfig
else
TARGET_KERNEL_DEFCONFIG := s5p4418_con_svma_pie_quickboot_defconfig
endif
TARGET_KERNEL_SRC := vendor/nexell/kernel/kernel-4.4.x
TARGET_KERNEL_ARCH := arm
DTB_OUTDIR := out/target/product/s5p4418_con_svma/obj/KERNEL_OBJ
DTB_DIR := ${DTB_OUTDIR}/arch/arm/boot/dts
DTIMG_ARG := "${DTB_DIR}/s5p4418-con_svma-rev00.dtb --id=0"
DTIMG_ARG += "${DTB_DIR}/s5p4418-con_svma-rev01.dtb --id=1"
BOARD_PREBUILT_DTBOIMAGE := out/target/product/s5p4418_con_svma/dtbo_con_svma.img

# BL1 Setting
CHIPNAME := nxp4330
BL1_BOARD_NAME := con_svma
KERNEL_VER := 4
SYSLOG := n
DEVICE_PORT := 0
TARGET_BL1_SRC := vendor/nexell/bl1/bl1-s5p4418

#BL2+ARMV7-Dispatcher Setting
TARGET_BL2_SRC := vendor/nexell/secure/bl2-s5p4418
TARGET_ARM7_DISPACHER_SRC := vendor/nexell/secure/armv7-dispatcher
DEV_PORTNUM := 0

# UBOOT Setting
SOC_NAME := s5p4418
TARGET_UBOOT_ARCH := arm
UBOOT_CONFIG := s5p4418_con_svma_config
TARGET_UBOOT_SRC := vendor/nexell/u-boot/u-boot-2016.01
SECURE_BINGEN := vendor/nexell/tools/SECURE_BINGEN


#fip_loader

# memory info
MEMSIZE := 2GB
ifeq ($(MEMSIZE), 2GB)
    UBOOT_IMG_LOAD_ADDR := 0x43c00000
    UBOOT_IMG_JUMP_ADDR := 0x43c00000
    FIP_LOAD_ADDR := 63c00000
    FIP_JUMP_ADDR := 63c00000

else ifeq ($(MEMSIZE), 1GB)
    UBOOT_IMG_LOAD_ADDR := 0x74c00000
    UBOOT_IMG_JUMP_ADDR := 0x74c00000
    FIP_LOAD_ADDR := 83c00000
    FIP_JUMP_ADDR := 83c00000
endif
#gen_bootloader
BOOTLOADER_PARTITION_SIZE := 4915200
#loader=LOADER_BIN
#secure=BL_MON_BIN -> SECURE_BIN
#nonsecure=UBOOT_BIN
#param=PARAM_BIN
BOOT_LOGO := device/nexell/con_svma/common/logo.bmp
OFFSET_SECURE=196608        # 0x40000 - 0x10000 = 0x 30000
OFFSET_NONSECURE=1900544    #0x1E0000 - 0x10000 = 0x1D0000
OFFSET_PARAM=2949120        #0x2E0000 - 0x10000 = 0x2D0000
OFFSET_BOOTLOGO=2965504     #0x2E4000 - 0x10000 = 0x2D4000


