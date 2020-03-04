
PRODUCT_CAR := true


$(call inherit-product, device/nexell/con_svma/common/automotive/auto.mk)

PRODUCT_NAME := s5p6818_con_svma_auto
PRODUCT_DEVICE := s5p6818_con_svma
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on con_svma auto
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma


BOARD_PLAT_PUBLIC_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/private


# automatically called
-include device/nexell/con_svma/common/device_common.mk

DEVICE_MANIFEST_FILE := device/nexell/con_svma/common/manifest_car.xml

-include device/nexell/con_svma/s5p6818_con_svma/common.mk

DEVICE_PACKAGE_OVERLAYS := device/nexell/con_svma/common/overlay_car
BOOTCMD_A=aboot load_kernel 0x5480 0x4007f000;
BOOTCMD_A+=dtimg load_mmc 0x42480 0x49000000 $$\{board_rev\};
BOOTCMD_A+=if test !-z $$\{change_devicetree\}; then run change_devicetree; fi;
BOOTCMD_A+=bootm 0x4007f000 - 0x49000000

BOOTCMD_B=aboot load_kernel 0x23c80 0x4007f000;
BOOTCMD_B+=dtimg load_mmc 0x44480 0x49000000 $$\{board_rev\};
BOOTCMD_B+=if test !-z $$\{change_devicetree\}; then run change_devicetree; fi;
BOOTCMD_B+=bootm 0x4007f000 - 0x49000000

RECOVERY_BOOTCMD_A=aboot load_mmc 0x5480 0x4007f000 0x48000000;
RECOVERY_BOOTCMD_A+=dtimg load_mmc 0x42480 0x49000000 $$\{board_rev\};
RECOVERY_BOOTCMD_A+=if test !-z $$\{change_devicetree\};then run change_devicetree; fi;
RECOVERY_BOOTCMD_A+=booti 0x4007f000 0x48000000:$$\{ramdisk_size\} 0x49000000

RECOVERY_BOOTCMD_B=aboot load_mmc 0x23c80 0x4007f000 0x48000000;
RECOVERY_BOOTCMD_B+=dtimg load_mmc 0x44480 0x49000000 $$\{board_rev\};
RECOVERY_BOOTCMD_B+=if test !-z $$\{change_devicetree\};then run change_devicetree; fi;
RECOVERY_BOOTCMD_B+=booti 0x4007f000 0x48000000:$$\{ramdisk_size\} 0x49000000

NXQUICKREAR_ARGS_0=nx_cam.m=-m2 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r704x480 nx_cam.end
NXQUICKREAR_ARGS_1=nx_cam.m=-m9 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r1280x720 nx_cam.end


UBOOT_BOOTARGS=console=ttySAC0,115200n8 printk.time=1
UBOOT_BOOTARGS+=androidboot.hardware=con_svma androidboot.console=ttySAC0
UBOOT_BOOTARGS+=androidboot.serialno=0123456789abcdef
UBOOT_BOOTARGS+=root=\/dev\/mmcblk0p2 ro rootwait rootfstype=ext4
UBOOT_BOOTARGS+=init=\/sbin\/nx_init skip_initramfs vmalloc=384M
UBOOT_BOOTARGS+=androidboot.selinux=permissive
UBOOT_BOOTARGS+=product_part=\/dev\/mmcblk0p13
UBOOT_BOOTARGS+=loglevel=4 quiet
UBOOT_BOOTARGS+=blkdevparts=mmcblk0:4915200@66048(bootloader_a),4915200@5046784(bootloader_b),62914560@11075584(boot_a),2097152@73990114(extended),62914560@75038720(boot_b),3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),1073741824@147390464(system_a),1073741824@1222180864(system_b),268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),1048576@2835939328(misc),3145728@2838036480(product),305237797168@2842230784(userdata)

UBOOT_RECOVERY_BOOTARGS=console=ttySAC0,115200n8 printk.time=1
UBOOT_RECOVERY_BOOTARGS+=androidboot.hardware=con_svma androidboot.console=ttySAC0
UBOOT_RECOVERY_BOOTARGS+=androidboot.serialno=0123456789abcdef
UBOOT_RECOVERY_BOOTARGS+=blkdevparts=mmcblk0:4915200@66048(bootloader_a),4915200@5046784(bootloader_b),62914560@11075584(boot_a),2097152@73990114(extended),62914560@75038720(boot_b),3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),1073741824@147390464(system_a),1073741824@1222180864(system_b),268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),1048576@2835939328(misc),3145728@2838036480(product),=305237797168@2842230784(userdata)

SPLASH_SOURCE="mmc"
SPLASH_OFFSET="0x2e4200"
$(call inherit-product-if-exists, vendor/nexell/app/automotive/nexell_connectivity.mk)
$(call inherit-product-if-exists, vendor/nexell/app/svm_daemon/svm-daemon.mk)
$(call inherit-product-if-exists, vendor/nexell/app/nx_backgear_service/nxbackgearservice.mk)
$(call inherit-product-if-exists, vendor/nexell/app/nx_rearcam_app/nxrearcam.mk)
$(call inherit-product-if-exists, vendor/nexell/app/nx_svm_app/nxsvm.mk)
$(call inherit-product-if-exists, vendor/nexell/app/nx_svm_autocalibration/nxsvmautocalibration.mk)
$(call inherit-product-if-exists, vendor/nexell/app/nx_svm_demo/nxsvmdemo.mk)
$(call inherit-product-if-exists, vendor/nexell/app/nx_svm_viewmode_editor/nxsvmviewmodeeditor.mk)

PRODUCT_PACKAGES += \
    nx_init

PRODUCT_PACKAGES += \
    NxQuickRearCam




