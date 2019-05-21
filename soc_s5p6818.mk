PRODUCT_COPY_FILES += \
    device/nexell/kernel/kernel-4.4.x/arch/arm64/boot/Image:kernel \
    device/nexell/kernel/kernel-4.4.x/arch/arm64/boot/dts/nexell/s5p6818-con_svma-rev01.dtb:2ndbootloader

# fstab
PRODUCT_COPY_FILES += \
    device/nexell/con_svma/init.$(PRODUCT_HARDWARE).s5p6818.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_HARDWARE).rc \
    device/nexell/con_svma/fstab.s5p6818:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_HARDWARE)
