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

PRODUCT_SHIPPING_API_LEVEL := 25

# Camera App
PRODUCT_PACKAGES += \
	Camera

PRODUCT_COPY_FILES += \
	device/nexell/con_svma/init.con_svma.rc:root/init.con_svma.rc \
	device/nexell/con_svma/init.con_svma.usb.rc:root/init.con_svma.usb.rc \
	device/nexell/con_svma/fstab.con_svma:root/fstab.con_svma \
	device/nexell/con_svma/ueventd.con_svma.rc:root/ueventd.con_svma.rc \
	device/nexell/con_svma/init.recovery.con_svma.rc:root/init.recovery.con_svma.rc \
    device/nexell/con_svma/busybox:system/bin/busybox \
    device/nexell/con_svma/hwreg_cmd:system/bin/hwreg_cmd \
    device/nexell/con_svma/memtester:system/bin/memtester \
    device/nexell/con_svma/memtester:root/memtester

# nx_3d_avm_camsys
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nx_3d_avm/3DS/gtr3ds/body.bmp:system/bin/nx_3d_avm/3DS/gtr3ds/body.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/gtr3ds/GTR.3ds:system/bin/nx_3d_avm/3DS/gtr3ds/GTR.3ds \
	device/nexell/con_svma/nx_3d_avm/3DS/gtr3ds_complexed/body.bmp:system/bin/nx_3d_avm/3DS/gtr3ds_complexed/body.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/gtr3ds_complexed/body_512x512.bmp:system/bin/nx_3d_avm/3DS/gtr3ds_complexed/body_512x512.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/gtr3ds_complexed/GTR.3ds:system/bin/nx_3d_avm/3DS/gtr3ds_complexed/GTR.3ds \
	device/nexell/con_svma/nx_3d_avm/3DS/gtr3ds_complexed/spot_light_256x256.BMP:system/bin/nx_3d_avm/3DS/gtr3ds_complexed/spot_light_256x256.BMP \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_256.pkm:system/bin/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_256.pkm \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_256_yuv.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_256_yuv.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_256_yuv.pkm:system/bin/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_256_yuv.pkm \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_512.pkm:system/bin/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_512.pkm \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_512_yuv.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_512_yuv.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_512_yuv.pkm:system/bin/nx_3d_avm/3DS/mobis_sonata2018/body_cmf09_512_yuv.pkm \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/model.3ds:system/bin/nx_3d_avm/3DS/mobis_sonata2018/model.3ds \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/model.nx:system/bin/nx_3d_avm/3DS/mobis_sonata2018/model.nx \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/normal64.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/normal64.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/normal512.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/normal512.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/spot128.pkm:system/bin/nx_3d_avm/3DS/mobis_sonata2018/spot128.pkm \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/spot128_yuv.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/spot128_yuv.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/spot128_yuv.pkm:system/bin/nx_3d_avm/3DS/mobis_sonata2018/spot128_yuv.pkm \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/spot256.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/spot256.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/mobis_sonata2018/spot256_yuv.bmp:system/bin/nx_3d_avm/3DS/mobis_sonata2018/spot256_yuv.bmp \
	device/nexell/con_svma/nx_3d_avm/3DS/spot_light_256x256.BMP:system/bin/nx_3d_avm/3DS/spot_light_256x256.BMP \
	device/nexell/con_svma/nx_3d_avm/avm/input_image/avm_full_data.yuv:system/bin/nx_3d_avm/avm/input_image/avm_full_data.yuv \
	device/nexell/con_svma/nx_3d_avm/avm/avm_info_3dview.data:system/bin/nx_3d_avm/avm/avm_info_3dview.data \
	device/nexell/con_svma/nx_3d_avm/avm/avm_info_eventview.data:system/bin/nx_3d_avm/avm/avm_info_eventview.data \
	device/nexell/con_svma/nx_3d_avm/avm/avm_info_topview.data:system/bin/nx_3d_avm/avm/avm_info_topview.data \
	device/nexell/con_svma/nx_3d_avm/nx_3d_avm_camsys:system/bin/nx_3d_avm/nx_3d_avm_camsys

PRODUCT_COPY_FILES += \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# audio
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/nexell/con_svma/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
    device/nexell/con_svma/audio_policy_volumes.xml:system/etc/audio_policy_volumes.xml \
    device/nexell/con_svma/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \
    device/nexell/con_svma/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \
    device/nexell/con_svma/r_submix_audio_policy_configuration.xml:system/etc/r_submix_audio_policy_configuration.xml \
    device/nexell/con_svma/default_volume_tables.xml:system/etc/default_volume_tables.xml

PRODUCT_COPY_FILES += \
    device/nexell/con_svma/audio/tiny_hw.con_svma.xml:system/etc/tiny_hw.con_svma.xml \
    device/nexell/con_svma/audio/audio_policy.conf:system/etc/audio_policy.conf

PRODUCT_COPY_FILES += \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	device/nexell/con_svma/media_codecs.xml:system/etc/media_codecs.xml \
	device/nexell/con_svma/media_profiles.xml:system/etc/media_profiles.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml

# bluetooth
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	device/nexell/con_svma/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
	device/nexell/con_svma/bluetooth/BCM434545.hcd:system/vendor/firmware/BCM434545.hcd \
	device/nexell/con_svma/bluetooth/BCM20710A1_001.002.014.0103.0117.hcd:system/vendor/firmware/BCM20710A1_001.002.014.0103.0117.hcd

# connection service
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.connectionservice.xml:system/etc/permissions/android.software.connectionservice.xml

# input
PRODUCT_COPY_FILES += \
	device/nexell/con_svma/gpio_keys.kl:system/usr/keylayout/gpio_keys.kl \
	device/nexell/con_svma/gpio_keys.kcm:system/usr/keychars/gpio_keys.kcm

# hardware features
PRODUCT_COPY_FILES += \
	device/nexell/con_svma/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml

# Recovery
PRODUCT_PACKAGES += \
	librecovery_updater_nexell

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_CONFIG += mdpi xlarge large
PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_AAPT_PREBUILT_DPI := hdpi mdpi ldpi
PRODUCT_CHARACTERISTICS := tablet

# OpenGL ES API version: 2.0
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072

# density
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160

# libion needed by gralloc, ogl
PRODUCT_PACKAGES += libion iontest

PRODUCT_PACKAGES += libdrm

# HAL
PRODUCT_PACKAGES += \
	gralloc.con_svma \
	libGLES_mali \
	hwcomposer.con_svma \
	audio.primary.con_svma \
	memtrack.con_svma \
	camera.con_svma

PRODUCT_PACKAGES += fs_config_files

# omx
PRODUCT_PACKAGES += \
	libstagefrighthw \
	libnx_video_api \
	libNX_OMX_VIDEO_DECODER \
	libNX_OMX_VIDEO_ENCODER \
	libNX_OMX_Base \
	libNX_OMX_Core \
	libNX_OMX_Common

# stagefright FFMPEG compnents
ifeq ($(EN_FFMPEG_AUDIO_DEC),true)
PRODUCT_PACKAGES += libNX_OMX_AUDIO_DECODER_FFMPEG
endif

ifeq ($(EN_FFMPEG_EXTRACTOR),true)
PRODUCT_PACKAGES += libNX_FFMpegExtractor
endif

# wifi
PRODUCT_PACKAGES += \
	libwpa_client \
	hostapd \
	wpa_supplicant \
	wpa_supplicant.conf

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0

DEVICE_PACKAGE_OVERLAYS := device/nexell/con_svma/overlay

# increase dex2oat threads to improve booting time
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.boot-dex2oat-threads=4 \
	dalvik.vm.dex2oat-threads=4 \
	dalvik.vm.image-dex2oat-threads=4

#Enabling video for live effects
-include frameworks/base/data/videos/VideoPackage1.mk

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=8m

# HWUI common settings
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.gradient_cache_size=1 \
    ro.hwui.drop_shadow_cache_size=6 \
    ro.hwui.r_buffer_cache_size=8 \
    ro.hwui.texture_cache_flushrate=0.4 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=1024 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=1024

# skip boot jars check
SKIP_BOOT_JARS_CHECK := true

# bootanimation
PRODUCT_COPY_FILES += \
	device/nexell/con_svma/bootanimation.zip:system/media/bootanimation.zip

# wifi
PRODUCT_COPY_FILES += \
	device/nexell/con_svma/wifi/dhd:system/bin/dhd \
	device/nexell/con_svma/wifi/wl:system/bin/wl \
	device/nexell/con_svma/wifi/bcmdhd.cal:system/etc/wifi/bcmdhd.cal \
	device/nexell/con_svma/wifi/fw_bcmdhd.bin:system/etc/firmware/fw_bcmdhd.bin \
	device/nexell/con_svma/wifi/fw_bcmdhd_apsta.bin:system/etc/firmware/fw_bcmdhd_apsta.bin

$(call inherit-product, frameworks/base/data/fonts/fonts.mk)
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)
