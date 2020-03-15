
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

PRODUCT_NAME := s5p4418_con_svma
PRODUCT_DEVICE := s5p4418_con_svma
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on con_svma
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma

# automatically called
-include device/nexell/con_svma/common/device_common.mk

DEVICE_MANIFEST_FILE := device/nexell/con_svma/common/manifest.xml

-include device/nexell/con_svma/s5p4418_con_svma/common.mk

DEVICE_PACKAGE_OVERLAYS := device/nexell/con_svma/common/overlay

#sepolicy
BOARD_SEPOLICY_DIRS := device/nexell/con_svma/common/sepolicy/vendor
BOARD_PLAT_PUBLIC_SEPOLICY_DIR := device/nexell/con_svma/common/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR := device/nexell/con_svma/common/sepolicy/private


BOOTCMD_A=aboot load_zImage 0x5480 0x40008000;
BOOTCMD_A+=dtimg load_mmc 0x42480 0x49000000 $$\{board_rev\};
BOOTCMD_A+=if test !-z $$\{change_devicetree\}; then run change_devicetree; fi;
BOOTCMD_A+=bootz 0x40008000 - 0x49000000

BOOTCMD_B=aboot load_zImage 0x23c80 0x40008000;
BOOTCMD_B+=dtimg load_mmc 0x44480 0x49000000 $$\{board_rev\};
BOOTCMD_B+=if test !-z $$\{change_devicetree\}; then run change_devicetree; fi;
BOOTCMD_B+=bootz 0x40008000 - 0x49000000

RECOVERY_BOOTCMD_A=aboot load_mmc 0x5480 0x40008000 0x48000000;
RECOVERY_BOOTCMD_A+=dtimg load_mmc 0x42480 0x49000000 $$\{board_rev\};
RECOVERY_BOOTCMD_A+=if test !-z $$\{change_devicetree\};then run change_devicetree; fi;
RECOVERY_BOOTCMD_A+=bootz 0x40008000 0x48000000:$$\{ramdisk_size\} 0x49000000

RECOVERY_BOOTCMD_B=aboot load_mmc 0x23c80 0x40008000 0x48000000;
RECOVERY_BOOTCMD_B+=dtimg load_mmc 0x44480 0x49000000 $$\{board_rev\};
RECOVERY_BOOTCMD_B+=if test !-z $$\{change_devicetree\};then run change_devicetree; fi;
RECOVERY_BOOTCMD_B+=bootz 0x40008000 0x48000000:$$\{ramdisk_size\} 0x49000000

NXQUICKREAR_ARGS_0=nx_cam.m=-m1 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r704x480 nx_cam.end
NXQUICKREAR_ARGS_1=nx_cam.m=-m6 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r1280x720 nx_cam.end


UBOOT_BOOTARGS=console=ttyAMA3,115200n8 printk.time=1
UBOOT_BOOTARGS+=androidboot.hardware=con_svma androidboot.console=ttyAMA3
UBOOT_BOOTARGS+=androidboot.serialno=0123456789abcdef
UBOOT_BOOTARGS+=root=\/dev\/mmcblk0p2 ro rootwait rootfstype=ext4
UBOOT_BOOTARGS+=init=\/init skip_initramfs vmalloc=384M
UBOOT_BOOTARGS+=androidboot.selinux=permissive
UBOOT_BOOTARGS+=product_part=\/dev\/mmcblk0p13
UBOOT_BOOTARGS+=loglevel=7
UBOOT_BOOTARGS+=blkdevparts=mmcblk0:4915200@66048(bootloader_a),4915200@5046784(bootloader_b),62914560@11075584(boot_a),2097152@73990114(extended),62914560@75038720(boot_b),3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),1073741824@147390464(system_a),1073741824@1222180864(system_b),268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),1048576@2835939328(misc),3145728@2838036480(product),305237797168@2842230784(userdata)

UBOOT_RECOVERY_BOOTARGS=console=ttyAMA3,115200n8 printk.time=1
UBOOT_RECOVERY_BOOTARGS+=androidboot.hardware=con_svma androidboot.console=ttyAMA3
UBOOT_RECOVERY_BOOTARGS+=androidboot.serialno=0123456789abcdef
UBOOT_RECOVERY_BOOTARGS+=blkdevparts=mmcblk0:4915200@66048(bootloader_a),4915200@5046784(bootloader_b),62914560@11075584(boot_a),2097152@73990114(extended),62914560@75038720(boot_b),3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),1073741824@147390464(system_a),1073741824@1222180864(system_b),268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),1048576@2835939328(misc),3145728@2838036480(product),305237797168@2842230784(userdata)

SPLASH_SOURCE="mmc"
SPLASH_OFFSET="0x2e4200"

#camera
PRODUCT_PACKAGES += \
	camera.s5pxx18 \
	android.hardware.memtrack@1.0-service \
	android.hardware.camera.provider@2.4-impl \
	android.hardware.camera.provider@2.4-service \
	camera.device@3.4-impl

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml
