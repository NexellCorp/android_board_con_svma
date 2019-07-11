# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/init.$(PRODUCT_HARDWARE).s5p6818.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc \
    device/nexell/con_svma/fstab.s5p6818:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)
