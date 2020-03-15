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

TARGET_USES_64_BIT_BINDER := true

# misc by-name path
NEXELL_MISC_PARTITION := /dev/block/by-name/misc

# bluetooth
BOARD_CUSTOM_BT_CONFIG := device/nexell/con_svma/s5p6818_con_svma/bluetooth_config/vnd_con_svma_s5p6818.txt
# Kernel & DTB Setting
ifneq ($(QUICKBOOT), 1)
TARGET_KERNEL_DEFCONFIG := s5p6818_con_svma_pie_defconfig
else
TARGET_KERNEL_DEFCONFIG := s5p6818_con_svma_pie_quickboot_defconfig
endif
TARGET_KERNEL_SRC := vendor/nexell/kernel/kernel-4.4.x
TARGET_KERNEL_ARCH := arm64
DTB_OUTDIR := out/target/product/s5p6818_con_svma/obj/KERNEL_OBJ
DTB_DIR := ${DTB_OUTDIR}/arch/arm64/boot/dts/nexell
DTIMG_ARG := ${DTB_DIR}/s5p6818-con_svma-rev01.dtb --id=1
BOARD_PREBUILT_DTBOIMAGE := out/target/product/s5p6818_con_svma/dtbo_con_svma.img

# BL1 Setting
BL1_BOARD_NAME := con_svma
KERNEL_VER := 4
SYSLOG := n
DEVICE_PORT := 2
TARGET_BL1_SRC := vendor/nexell/bl1/bl1-s5p6818

# UBOOT Setting
SOC_NAME := s5p6818
TARGET_UBOOT_ARCH := arm64
UBOOT_CONFIG := s5p6818_con_svma_config
TARGET_UBOOT_SRC := vendor/nexell/u-boot/u-boot-2016.01
SECURE_BINGEN := vendor/nexell/tools/SECURE_BINGEN


#optee Setting
UBOOT_LOAD_ADDR := 0x4007f000
OFFSET_LOADER := 65536
OFFSET_SECURE := 327680             #0x50000 = 0x60000 - 0x10000
OFFSET_SECURE_HEAD := 393728       #0x60200 : 0x60000 + 0x200(NSIH) = 393728
OFFSET_NONSECURE := 1900544         #0x1D0000 = 0x1E0000 - 0x10000
OFFSET_NONSECURE_HEAD := 1966592   #0x1E0000 : 0x1E0000 + 0x200(NSIH) = 1966592
OFFSET_PARAM := 2949120             #0x2D0000 = 0x2E0000 - 0x10000
OFFSET_BOOTLOGO := 2965504          #0x2D4000 = 0x2E4000 - 0x10000
TARGET_OPTEE_SRC := vendor/nexell/secure
OPTEE_BUILD_OPT := PLAT_DRAM_SIZE=2048 PLAT_UART_BASE=0xc00a1000 SECURE_ON=0 SUPPORT_ANDROID=1
OPTEE_BUILD_OPT += CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE32=arm-linux-gnueabihf-
OPTEE_BUILD_OPT += SUPPORT_OTA_AB_UPDATE=1
OPTEE_BUILD_OPT += UBOOT_DIR=vendor/nexell/u-boot/u-boot-2016.01
ifeq ($(QUICKBOOT), 1)
OPTEE_BUILD_OPT += QUICKBOOT=1
endif

#gen_bootloader
BOOTLOADER_PARTITION_SIZE := 4915200
BOOT_LOGO := device/nexell/con_svma/common/logo.bmp
