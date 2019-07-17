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

LOCAL_PATH := device/nexell/con_svma

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

TARGET_RELEASETOOLS_EXTENSIONS := device/nexell/con_svma

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
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 4096
BOARD_VENDORIMAGE_PARTITION_SIZE := 268435456
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 4711972930
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 3145728
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product

#KERNEL
TARGET_PREBUILT_KERNEL = device/nexell/con_svma/kernel
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)

# DTBO partition definitions
BOARD_PREBUILT_DTBOIMAGE := device/nexell/con_svma/dtbo.img
BOARD_DTBOIMG_PARTITION_SIZE := 3145728

# graphics
BOARD_EGL_CFG := $(LOCAL_PATH)/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_USES_ION := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
# see surfaceflinger
MAX_VIRTUAL_DISPLAY_DIMENSION := 2048

#sepolicy
BOARD_SEPOLICY_DIRS := $(LOCAL_PATH)/sepolicy/vendor
BOARD_PLAT_PUBLIC_SEPOLICY_DIR := $(LOCAL_PATH)/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR := $(LOCAL_PATH)/sepolicy/private
# car related sepolicy
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/private

# vendor interface manifest
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/manifest.xml

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
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/nexell/con_svma/bluetooth
BOARD_CUSTOM_BT_CONFIG := device/nexell/con_svma/bluetooth/vnd_con_svma.txt

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
