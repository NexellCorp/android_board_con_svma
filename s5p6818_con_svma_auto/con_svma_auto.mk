
PRODUCT_CAR := true

$(call inherit-product, device/nexell/con_svma/s5p6818_con_svma_auto/automotive/auto.mk)

PRODUCT_NAME := s5p6818_con_svma_auto
PRODUCT_DEVICE := s5p6818_con_svma_auto
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on con_svma auto
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma

# automatically called
$(call inherit-product, device/nexell/con_svma/s5p6818_con_svma_auto/device.mk)


