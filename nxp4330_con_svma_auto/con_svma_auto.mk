
PRODUCT_CAR := true

$(call inherit-product, device/nexell/con_svma/nxp4330_con_svma_auto/automotive/auto.mk)

PRODUCT_NAME := nxp4330_con_svma_auto
PRODUCT_DEVICE := nxp4330_con_svma_auto
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on con_svma auto
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma

SKIP_ABI_CHECKS := true

# automatically called
$(call inherit-product, device/nexell/con_svma/nxp4330_con_svma_auto/device.mk)


