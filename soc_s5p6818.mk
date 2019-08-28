# init.{PRODUCT_HARDWARE}.rc
ifeq ($(QUICKBOOT), 1)
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/init.$(PRODUCT_HARDWARE).s5p6818.quickboot.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc
else
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/init.$(PRODUCT_HARDWARE).s5p6818.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc
endif

# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/fstab.s5p6818:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)

# bluetooth
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/bluetooth/bt_vendor_s5p6818.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor.conf

#recovery
TARGET_RECOVERY_FSTAB := device/nexell/con_svma/fstab.s5p6818
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.con_svma.rc:root/init.recovery.$(PRODUCT_HARDWARE).rc
