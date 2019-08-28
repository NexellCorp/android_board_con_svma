# kernel
# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/init.$(PRODUCT_HARDWARE).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc \
    device/nexell/con_svma/fstab.$(PRODUCT_HARDWARE):$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)

# bluetooth
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/bluetooth/bt_vendor_s5p4418.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor.conf

#recovery
TARGET_RECOVERY_FSTAB := device/nexell/con_svma/fstab.con_svma
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.con_svma.rc:root/init.recovery.$(PRODUCT_HARDWARE).rc
