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
NEXELL_MISC_PARTITION := /dev/block/platform/c0000000.soc/c0062000.dw_mmc/by-name/misc

# bluetooth
BOARD_CUSTOM_BT_CONFIG := device/nexell/con_svma/s5p4418_con_svma/bluetooth_config/vnd_con_svma_s5p4418.txt


# Kernel & DTB Setting
TARGET_KERNEL_DEFCONFIG := s5p4418_con_svma_pie_defconfig
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
UBOOT_CONFIG := s5p4418_con_svma_config
TARGET_UBOOT_SRC := vendor/nexell/u-boot/u-boot-2016.01
SECURE_BINGEN := vendor/nexell/tools/SECURE_BINGEN

# Secure Setting

# uboot make env
MEMSIZE := 2GB
PAGESIZE := 4096
OTA_AB_UPDATE := true
ADDRESS := 0x93c00000
ifeq ($(MEMSIZE), 2GB)
    ADDRESS := 0x63c00000
    UBOOT_LOAD_ADDR := 0x40008000
    UBOOT_IMG_LOAD_ADDR := 0x43c00000
    UBOOT_IMG_JUMP_ADDR := 0x43c00000
else ifeq ($(MEMSIZE), 1GB)
    ADDRESS := 0x83c00000
    UBOOT_LOAD_ADDR := 0x71008000
    UBOOT_IMG_LOAD_ADDR := 0x74c00000
    UBOOT_IMG_JUMP_ADDR := 0x74c00000
endif
PARTMAP_TXT := partmap_legacy.txt
ifeq ($(OTA_AB_UPDATE), true)
    PARTMAP_TXT := partmap_AB_update.txt
endif
PART_MAP := ${DEVICE_DIR}/${PARTMAP_TXT}
PART_NAME1 := boot_a:emmc
PART_NAME2 := boot_b:emmc

#export UBOOT_DIR DEVICE_DIR PARTMAP_TXT UBOOT_LOAD_ADDR PAGESIZE TARGET_SOC
