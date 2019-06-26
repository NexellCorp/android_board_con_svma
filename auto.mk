#
# Copyright (C) 2017 The Android Open Source Project
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
#
# DEVICE_MANIFEST_FILE += device/nexell/con_svma/manifest-auto.xml

$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, device/nexell/con_svma/soc.mk)
$(call inherit-product, device/nexell/con_svma/device.mk)

################################################
# Begin general Android Auto Embedded configurations

PRODUCT_COPY_FILES += \
    packages/services/Car/car_product/init/init.bootstat.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.bootstat.rc \
    packages/services/Car/car_product/init/init.car.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.car.rc

# Auto core hardware permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/car_core_hardware.xml:system/etc/permissions/car_core_hardware.xml

# Enable landscape
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml

# Broadcast Radio permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.broadcastradio.xml:system/etc/permissions/android.hardware.broadcastradio.xml

# vehicle HAL
PRODUCT_PACKAGES += \
    android.hardware.automotive.vehicle@2.0-service

# Broadcast Radio
PRODUCT_PACKAGES += \
    android.hardware.broadcastradio@2.0-service

# AudioControl HAL
PRODUCT_PACKAGES += \
    android.hardware.automotive.audiocontrol@1.0-service-nexell

BOARD_SEPOLICY_DIRS += \
    device/generic/car/common/sepolicy

BOARD_IS_AUTOMOTIVE := true
TARGET_USES_CAR_FUTURE_FEATURES := true

$(call inherit-product, packages/services/Car/car_product/build/car.mk)
