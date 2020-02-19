
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

PRODUCT_NAME := s5p6818_con_svma
PRODUCT_DEVICE := s5p6818_con_svma
PRODUCT_BRAND := con_svma
PRODUCT_MODEL := con_svma
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma

# automatically called
-include device/nexell/con_svma/common/device_common.mk

DEVICE_MANIFEST_FILE := device/nexell/con_svma/common/manifest.xml

-include device/nexell/con_svma/s5p6818_con_svma/common.mk


