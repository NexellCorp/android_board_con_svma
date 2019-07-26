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

PRODUCT_HARDWARE := con_svma
LOCAL_PATH := device/nexell/$(PRODUCT_HARDWARE)

########################################################################
# PRODUCT_AAPT_CONFIG
########################################################################

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_AAPT_PREBUILT_DPI := hdpi mdpi ldpi
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_SHIPPING_API_LEVEL := 26
DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay


########################################################################
# PRODUCT_PACKAGES
########################################################################

# ion
PRODUCT_PACKAGES += \
    libion \
    iontest

# graphic
PRODUCT_PACKAGES += \
    libdrm

# hidl
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0 \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.allocator@2.0 \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1 \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio@2.0-service \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.soundtrigger@2.0-impl

# hal
PRODUCT_PACKAGES += \
    gralloc.s5pxx18 \
    libGLES_mali \
    hwcomposer.s5pxx18 \
    lights.s5pxx18 \
    audio.primary.s5pxx18 \
    gatekeeper.s5pxx18 \
    bootctrl.s5pxx18

# audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

# input
PRODUCT_PACKAGES += \
    libtslib \
    inputraw \
    pthres \
    dejitter \
    linear \
    tscalib

# keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service \
    libsoftkeymasterdevice

# gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# usb
PRODUCT_PACKAGES += \
    android.hardware.usb@1.1-service-nexell

# VNDK libraries
PRODUCT_PACKAGES += \
    vndk_package

# neteutils
PRODUCT_PACKAGES += \
    netutils-wrapper-1.0

# wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0 \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi.hostapd@1.0 \
    wificond \
    wifilogd \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

# bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0 \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth.a2dp@1.0 \
    android.hardware.bluetooth.a2dp@1.0-impl \
    libbt-vendor

# power
PRODUCT_PACKAGES += \
    android.hardware.power@1.1-service

PRODUCT_PROPERTY_OVERRIDES += ro.hardware.power=nexell

# omx
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libNX_OMX_VIDEO_DECODER \
    libNX_OMX_VIDEO_ENCODER \
    libNX_OMX_Base \
    libNX_OMX_Core \
    libNX_OMX_Common

# ffmpeg extractor
EN_FFMPEG_EXTRACTOR := false
EN_FFMPEG_AUDIO_DEC := false

# automotive
PRODUCT_PACKAGES += \
	vhal_v2_0_defaults \
	android.hardware.automotive.vehicle@2.0-manager-lib \
	android.hardware.automotive.vehicle@2.0-default-impl-lib \
	android.hardware.automotive.vehicle@2.0-service \
	android.hardware.automotive.vehicle@2.0-libproto-native \
	android.hardware.automotive.vehicle@2.0

########################################################################
# PRODUCT_COPY_FILES
########################################################################

# init rc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.$(PRODUCT_HARDWARE).usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).usb.rc \

# filesystem
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ueventd.$(PRODUCT_HARDWARE).rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    # $(LOCAL_PATH)/fstab.$(PRODUCT_HARDWARE):$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)

# default feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.software.webview.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.webview.xml

# input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/input/gpio_keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio_keys.kl \
    $(LOCAL_PATH)/input/gpio_keys.kcm:$(TARGET_COPY_OUT_VENDOR)/usr/keychars/gpio_keys.kcm

# audio
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \

# usb
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \

# wifi
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    device/nexell/con_svma/wifi/dhd:$(TARGET_COPY_OUT_VENDOR)/bin/dhd \
    device/nexell/con_svma/wifi/wl:$(TARGET_COPY_OUT_VENDOR)/bin/wl \
    device/nexell/con_svma/wifi/bcmdhd.cal:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/bcmdhd.cal \
    device/nexell/con_svma/wifi/fw_bcmdhd.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/fw_bcmdhd.bin \
    device/nexell/con_svma/wifi/fw_bcmdhd_apsta.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/fw_bcmdhd_apsta.bin \
    device/nexell/con_svma/wifi/config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    device/nexell/con_svma/wifi/config/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf

# media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    device/nexell/con_svma/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml \
    device/nexell/con_svma/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml

# bluetooth
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    device/nexell/con_svma/bluetooth/BCM434545.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/BCM434545.hcd

# connection service
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.connectionservice.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.connectionservice.xml

########################################################################
# PRODUCT_PROPERTY_OVERRIDES
########################################################################

# OpenGL ES API version: 2.0
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# density
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160 \
	ro.sf.disable_triple_buffer=0

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapgrowthlimit=96m \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=2m

# media_profiles
PRODUCT_PROPERTY_OVERRIDES += \
    media.settings.xml=/vendor/etc/media_profiles.xml

# Enable AAudio MMAP/NOIRQ data path.
# 1 is AAUDIO_POLICY_NEVER  means only use Legacy path.
# 2 is AAUDIO_POLICY_AUTO   means try MMAP then fallback to Legacy path.
# 3 is AAUDIO_POLICY_ALWAYS means only use MMAP path.
PRODUCT_PROPERTY_OVERRIDES += aaudio.mmap_policy=2
# 1 is AAUDIO_POLICY_NEVER  means only use SHARED mode
# 2 is AAUDIO_POLICY_AUTO   means try EXCLUSIVE then fallback to SHARED mode.
# 3 is AAUDIO_POLICY_ALWAYS means only use EXCLUSIVE mode.
PRODUCT_PROPERTY_OVERRIDES += aaudio.mmap_exclusive_policy=2

# target definitions
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
  bootloader \
  boot \
  dtbo \
  system \
  vendor

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_NO_RECOVERY := true

#for brillo_update_payload install. see, build/core/Makefile
#make doest not null
TARGET_RECOVERY_FSTAB_EXTRA := use   # use or 'null'

BOARD_USES_RECOVERY_AS_BOOT := false
PRODUCT_PACKAGES += \
  cppreopts.sh \
  update_engine \
  update_verifier

PRODUCT_PACKAGES_DEBUG += update_engine_client

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \

# bootctrl HAL
PRODUCT_PACKAGES += \
    bootctrl.default \
    bootctrl.$(TARGET_BOARD_PLATFORM) \
    bootctl

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.ota_update_verifier=true

# A/B OTA post actions
PRODUCT_PACKAGES += cfigPostInstall
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=bin/cfigPostInstall \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# App compilation in background
PRODUCT_PACKAGES += otapreopt_script

AB_OTA_POSTINSTALL_CONFIG += \
  RUN_POSTINSTALL_system=true \
  POSTINSTALL_PATH_system=system/bin/otapreopt_script \
  FILESYSTEM_TYPE_system=ext4 \
  POSTINSTALL_OPTIONAL_system=true

# For A/B update test
PRODUCT_PACKAGES += \
  updater

# For vold
PRODUCT_PACKAGES += \
  fsck.exfat \
  mkfs.exfat \
  mount.exfat \
  fsck.ntfs \
  mkfs.ntfs \
  mount.ntfs

# libaaudio example
PRODUCT_PACKAGES += \
  input_monitor \
  input_monitor_callback \
  aaudio_loopback \
  write_sine \
  write_sine_callback

$(call add-product-sanitizer-module-config,wpa_supplicant,never)
$(call add-product-sanitizer-module-config,hostapd,never)
$(call inherit-product-if-exists, device/nexell/app/svm_daemon/svm-daemon.mk)
PRODUCT_PACKAGES += \
    nx_init

PRODUCT_PACKAGES += \
    NxQuickRearCam
