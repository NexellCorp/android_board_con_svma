ifeq ($(QUICKBOOT), 1)
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/init.$(PRODUCT_HARDWARE).quickboot.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc
# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/fstab.con_svma_auto:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)
#recovery
TARGET_RECOVERY_FSTAB := device/nexell/con_svma/nxp4330_con_svma/fstab.con_svma_auto
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/init.recovery.con_svma.rc:root/init.recovery.$(PRODUCT_HARDWARE).rc
else
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/init.$(PRODUCT_HARDWARE).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc
# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/fstab.con_svma:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)
#recovery
TARGET_RECOVERY_FSTAB := device/nexell/con_svma/nxp4330_con_svma/fstab.con_svma
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/init.recovery.con_svma.rc:root/init.recovery.$(PRODUCT_HARDWARE).rc
endif


# bluetooth
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/nxp4330_con_svma/bluetooth_config/bt_vendor_s5p4418.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor.conf

