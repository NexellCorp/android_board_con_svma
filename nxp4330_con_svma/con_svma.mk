
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

PRODUCT_NAME := nxp4330_con_svma
PRODUCT_DEVICE := nxp4330_con_svma
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on con_svma
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma

SKIP_ABI_CHECKS := true

# automatically called
$(call inherit-product, device/nexell/con_svma/nxp4330_con_svma/device.mk)


