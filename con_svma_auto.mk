
$(call inherit-product, device/nexell/con_svma/auto.mk)

PRODUCT_NAME := con_svma_auto
PRODUCT_DEVICE := con_svma
PRODUCT_BRAND := con_svma
PRODUCT_MODEL := con_svma auto
PRODUCT_MANUFACTURER := Nexell
ifeq ($(QUICKBOOT), 1)
PRODUCT_PACKAGE_OVERLAYS += device/nexell/con_svma/auto/overlay
endif
