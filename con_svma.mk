
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

PRODUCT_NAME := con_svma
PRODUCT_DEVICE := con_svma
PRODUCT_BRAND := con_svma
PRODUCT_MODEL := con_svma
PRODUCT_MANUFACTURER := Nexell

# automatically called
$(call inherit-product, device/nexell/con_svma/device.mk)
