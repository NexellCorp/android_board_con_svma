# kernel
PRODUCT_COPY_FILES += \
    device/nexell/kernel/kernel-4.4.x/arch/arm/boot/zImage:kernel \
    device/nexell/kernel/kernel-4.4.x/arch/arm/boot/dts/s5p4418-con_svma-rev00.dtb:2ndbootloader

# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/init.$(PRODUCT_HARDWARE).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc \
    device/nexell/con_svma/fstab.$(PRODUCT_HARDWARE):$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)
