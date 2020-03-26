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

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a9

# misc by-name path
NEXELL_MISC_PARTITION := /dev/block/by-name/misc

# Kernel & DTB Setting
TARGET_KERNEL_DEFCONFIG := s5p4418_con_svma_pie_auto_defconfig
TARGET_KERNEL_SRC := vendor/nexell/kernel/kernel-4.4.x
TARGET_KERNEL_ARCH := arm
DTB_OUTDIR := out/target/product/nxp4330_con_svma_auto/obj/KERNEL_OBJ
DTB_DIR := ${DTB_OUTDIR}/arch/arm/boot/dts
DTIMG_ARG :=${DTB_DIR}/s5p4418-con_svma_auto-rev00.dtb --id=0
DTIMG_ARG +=${DTB_DIR}/s5p4418-con_svma_auto-rev01.dtb --id=1
BOARD_PREBUILT_DTBOIMAGE := out/target/product/nxp4330_con_svma_auto/dtbo_con_svma.img


BOARD_VENDOR_KERNEL_MODULES += \
    $(KERNEL_OUT)/drivers/media/platform/nx-vpu/nx_vpu.ko \
    $(KERNEL_OUT)/drivers/mmc/host/dw_mmc-nexell_sdio_1.ko \
    $(KERNEL_OUT)/drivers/net/wireless/bcmdhd_cypress/bcmdhd.ko \
    $(KERNEL_OUT)/drivers/usb/gadget/function/usb_f_iap.ko \
    $(KERNEL_OUT)/drivers/usb/gadget/legacy/g_iap_ncm.ko

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
BOOT_LOGO := device/nexell/con_svma/nxp4330_con_svma_auto/logo.bmp
OFFSET_SECURE=196608        # 0x40000 - 0x10000 = 0x 30000
OFFSET_NONSECURE=1900544    #0x1E0000 - 0x10000 = 0x1D0000
OFFSET_PARAM=2949120        #0x2E0000 - 0x10000 = 0x2D0000
OFFSET_BOOTLOGO=2965504     #0x2E4000 - 0x10000 = 0x2D4000

BOOTCMD_A=aboot load_zImage 0x5480 0x40008000;
BOOTCMD_A+=dtimg load_mmc 0x42480 0x49000000 $$\{board_rev\};
BOOTCMD_A+=if test !-z $$\{change_devicetree\}; then run change_devicetree; fi;
BOOTCMD_A+=bootz 0x40008000 - 0x49000000

BOOTCMD_B=aboot load_zImage 0x23c80 0x40008000;
BOOTCMD_B+=dtimg load_mmc 0x44480 0x49000000 $$\{board_rev\};
BOOTCMD_B+=if test !-z $$\{change_devicetree\}; then run change_devicetree; fi;
BOOTCMD_B+=bootz 0x40008000 - 0x49000000

RECOVERY_BOOTCMD_A=aboot load_mmc 0x5480 0x40008000 0x48000000;
RECOVERY_BOOTCMD_A+=dtimg load_mmc 0x42480 0x49000000 $$\{board_rev\};
RECOVERY_BOOTCMD_A+=if test !-z $$\{change_devicetree\};then run change_devicetree; fi;
RECOVERY_BOOTCMD_A+=bootz 0x40008000 0x48000000:$$\{ramdisk_size\} 0x49000000

RECOVERY_BOOTCMD_B=aboot load_mmc 0x23c80 0x40008000 0x48000000;
RECOVERY_BOOTCMD_B+=dtimg load_mmc 0x44480 0x49000000 $$\{board_rev\};
RECOVERY_BOOTCMD_B+=if test !-z $$\{change_devicetree\};then run change_devicetree; fi;
RECOVERY_BOOTCMD_B+=bootz 0x40008000 0x48000000:$$\{ramdisk_size\} 0x49000000

NXQUICKREAR_ARGS_0=nx_cam.m=-m1 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r704x480 nx_cam.end
NXQUICKREAR_ARGS_1=nx_cam.m=-m6 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r1280x720 nx_cam.end


UBOOT_BOOTARGS=console=ttyAMA3,115200n8 printk.time=1
UBOOT_BOOTARGS+=androidboot.hardware=con_svma androidboot.console=ttyAMA3
UBOOT_BOOTARGS+=androidboot.serialno=0123456789abcdef
UBOOT_BOOTARGS+=root=\/dev\/mmcblk0p2 ro rootwait rootfstype=squashfs
UBOOT_BOOTARGS+=init=\/sbin\/nx_init skip_initramfs vmalloc=384M
UBOOT_BOOTARGS+=androidboot.selinux=permissive
UBOOT_BOOTARGS+=product_part=\/dev\/mmcblk0p13
UBOOT_BOOTARGS+=loglevel=4 quiet
UBOOT_BOOTARGS+=blkdevparts=mmcblk0:4915200@66048(bootloader_a),4915200@5046784(bootloader_b),62914560@11075584(boot_a),2097152@73990114(extended),62914560@75038720(boot_b),3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),1073741824@147390464(system_a),1073741824@1222180864(system_b),268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),1048576@2835939328(misc),3145728@2838036480(product),305237797168@2842230784(userdata)

UBOOT_RECOVERY_BOOTARGS=console=ttyAMA3,115200n8 printk.time=1
UBOOT_RECOVERY_BOOTARGS+=androidboot.hardware=con_svma androidboot.console=ttyAMA3
UBOOT_RECOVERY_BOOTARGS+=androidboot.serialno=0123456789abcdef
UBOOT_RECOVERY_BOOTARGS+=blkdevparts=mmcblk0:4915200@66048(bootloader_a),4915200@5046784(bootloader_b),62914560@11075584(boot_a),2097152@73990114(extended),62914560@75038720(boot_b),3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),1073741824@147390464(system_a),1073741824@1222180864(system_b),268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),1048576@2835939328(misc),3145728@2838036480(product),305237797168@2842230784(userdata)

SPLASH_SOURCE="mmc"
SPLASH_OFFSET="0x2e4200"

QUICKBOOT := 1
NEXELL_QUICKBOOT := true
# init rc service
CAMERA_SERVER_QUICKBOOT := true
MEDIA_DRM_SERVER_QUICKBOOT := true
BOOT_ANIMATION_QUICKBOOT := true
INCIDENTD_QUICKBOOT := true
STATSD_QUICKBOOT := true
OTA_PRE_OPT_QUICKBOOT := true
WIFI_SERVICE_QUICKBOOT := true
INIT_RC_QUICKBOOT := true
# CPP frameworks
BATTERY_NOTIFIER_QUICKBOOT := true
GUI_QUICKBOOT := true
OPEN_GL_QUICKBOOT := true
SURFACE_FLINGER_QUICKBOOT := true

# define targets
TARGET_BOARD_PLATFORM := s5pxx18
TARGET_BOOTLOADER_BOARD_NAME := con_svma

# do not stop building despite of build warning
BUILD_BROKEN_DUP_RULES := true

# images
TARGET_NO_BOOTLOADER := false
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true

TARGET_RECOVERY_WIPE = device/nexell/con_svma/nxp4330_con_svma_auto/recovery.wipe
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# boot image layout
BOARD_KERNEL_PAGESIZE := 4096
TARGET_BOOTLOADER_IS_2ND := false

# enable treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current

# use split vendor partition
TARGET_COPY_OUT_VENDOR := vendor

# filesystem
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := squashfs
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 4096
BOARD_VENDORIMAGE_PARTITION_SIZE := 268435456
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 4711972930
TARGET_COPY_OUT_PRODUCT := product
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 3145728
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_DTBOIMG_PARTITION_SIZE := 3145728
BOARD_FLASH_BLOCK_SIZE := 131072

DEVICE_MANIFEST_FILE := device/nexell/con_svma/nxp4330_con_svma_auto/manifest.xml

#sepolicy
BOARD_SEPOLICY_DIRS := device/nexell/con_svma/nxp4330_con_svma_auto/sepolicy/vendor
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += device/nexell/con_svma/nxp4330_con_svma_auto/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += device/nexell/con_svma/nxp4330_con_svma_auto/sepolicy/private

# graphics
BOARD_EGL_CFG := device/nexell/con_svma/nxp4330_con_svma_auto/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_USES_ION := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
# see surfaceflinger
MAX_VIRTUAL_DISPLAY_DIMENSION := 2048

# HIDL configstore
VSYNC_EVENT_PHASE_OFFSET_NS := 0
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 0
TARGET_USE_CONTEXT_PRIORITY := false
TARGET_HAS_WIDE_COLOR_DISPLAY := false
TARGET_HAS_HDR_DISPLAY := false
PRESENT_TIME_OFFSET_FROM_VSYNC_NS := 0
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := false
MAX_VIRTUAL_DISPLAY_DIMENSION := 2048
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := false
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
SF_PRIMARY_DISPLAY_ORIENTATION := 0

# audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := false

# camera
BOARD_CAMERA_BACK_DEVICE := "6"
BOARD_CAMERA_BACK_ORIENTATION := "0"
BOARD_CAMERA_NUM := 1
BOARD_CAMERA_USE_ZOOM := false
BOARD_CAMERA_SUPPORT_SCALING := true

# bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/nexell/con_svma/nxp4330_con_svma_auto/bluetooth
BOARD_CUSTOM_BT_CONFIG := device/nexell/con_svma/nxp4330_con_svma_auto/bluetooth/vnd_con_svma_s5p4418.txt

# bluetooth audio paths
SND_BT_CARD_ID := 0
SND_BT_DEVICE_ID := 0
SND_BT_SCO_CARD_ID := 0
SND_BT_SCO_DEVICE_ID := 1

# Wifi releated defines
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P     := ""
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_DRIVER_MODULE_NAME     := bcmdhd
WIFI_DRIVER_MODULE_PATH     := "/vendor/lib/modules/bcmdhd.ko"

#recovery
TARGET_RECOVERY_FSTAB := device/nexell/con_svma/nxp4330_con_svma_auto/fstab.con_svma

# target definitions
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
  bootloader \
  boot \
  dtbo \
  system \
  vendor

# A/B OTA post actions
AB_OTA_POSTINSTALL_CONFIG += \
  RUN_POSTINSTALL_system=true \
  POSTINSTALL_PATH_system=system/bin/otapreopt_script \
  FILESYSTEM_TYPE_system=squashfs \
  POSTINSTALL_OPTIONAL_system=true


