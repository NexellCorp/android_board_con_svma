#!/bin/bash

set -e

TOP=`pwd`
export TOP

source ${TOP}/device/nexell/con_svma/common.sh
source ${TOP}/device/nexell/tools/dir.sh
source ${TOP}/device/nexell/tools/make_build_info.sh
source ${TOP}/device/nexell/tools/revert_patches.sh

parse_args -s s5p4418 $@
print_args
setup_toolchain
export_work_dir

DTIMGE_TOOL=${TOP}/device/nexell/tools/mkdtimg

if [ "${QUICKBOOT}" == "true" ]; then
	KERNEL_ZIMAGE=false
	BUILD_SKIP_RECOVERY_KERNEL=false
fi


if [ "${QUICKBOOT}" == "true" ] ; then
    if [ "${KERNEL_ZIMAGE}" == "false" ] ; then
        PARTMAP_FILE=${TOP}/device/nexell/con_svma/partmap_svm_image.txt
    else
        PARTMAP_FILE=${TOP}/device/nexell/con_svma/partmap_svm.txt
    fi
else
    PARTMAP_FILE=${TOP}/device/nexell/con_svma/partmap.txt
fi

DEV_PORTNUM=0
MEMSIZE="2GB"

ADDRESS=0x93c00000
if [ "${MEMSIZE}" == "2GB" ]; then
    ADDRESS=0x63c00000
    UBOOT_LOAD_ADDR=0x40007800
    UBOOT_IMG_LOAD_ADDR=0x43c00000
    UBOOT_IMG_JUMP_ADDR=0x43c00000

elif [ "${MEMSIZE}" == "1GB" ]; then
    ADDRESS=0x83c00000
    UBOOT_LOAD_ADDR=0x71007800
    UBOOT_IMG_LOAD_ADDR=0x74c00000
    UBOOT_IMG_JUMP_ADDR=0x74c00000
fi

DEVICE_DIR=${TOP}/device/nexell/${BOARD_NAME}
OUT_DIR=${TOP}/out/target/product/${BOARD_NAME}

if [ "${KERNEL_ZIMAGE}" == "false" ] ; then
    if [ "${MEMSIZE}" == "2GB" ]; then
        UBOOT_LOAD_ADDR=0x40008000
    elif [ "${MEMSIZE}" == "1GB" ]; then
        UBOOT_LOAD_ADDR=0x71008000
    fi

    KERNEL_IMG=${KERNEL_DIR}/arch/arm/boot/Image
else
    KERNEL_IMG=${KERNEL_DIR}/arch/arm/boot/zImage
fi

RECOVERY_KERNEL_IMG=${KERNEL_DIR}/arch/arm/boot/zImage
DTB_IMG=${KERNEL_DIR}/arch/arm/boot/dts/s5p4418-con_svma-rev00.dtb


CROSS_COMPILE="arm-eabi-"

if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_BL1}" == "true" ]; then
	build_bl1_s5p4418 ${BL1_DIR}/bl1-${TARGET_SOC} nxp4330 con_svma 0
fi

if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_UBOOT}" == "true" ]; then
    build_uboot ${UBOOT_DIR} ${TARGET_SOC} ${BOARD_NAME} ${CROSS_COMPILE}
    gen_third ${TARGET_SOC} ${UBOOT_DIR}/u-boot.bin \
        ${UBOOT_IMG_LOAD_ADDR} ${UBOOT_IMG_JUMP_ADDR} \
        ${TOP}/device/nexell/secure/bootloader.img
fi

if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_SECURE}" == "true" ]; then
	pos=0
	file_size=0

	build_bl2_s5p4418 ${TOP}/device/nexell/secure/bl2-s5p4418
	build_armv7_dispatcher ${TOP}/device/nexell/secure/armv7-dispatcher

	gen_third ${TARGET_SOC} ${TOP}/device/nexell/secure/bl2-s5p4418/out/pyrope-bl2.bin \
		0xb0fe0000 0xb0fe0400 ${TOP}/device/nexell/secure/loader-emmc.img \
		"-m 0x40200 -b 3 -p ${DEV_PORTNUM} -m 0x1E0200 -b 3 -p ${DEV_PORTNUM} -m 0x60200 -b 3 -p ${DEV_PORTNUM}"
	gen_third ${TARGET_SOC} ${TOP}/device/nexell/secure/armv7-dispatcher/out/armv7_dispatcher.bin \
		0xffff0200 0xffff0200 ${TOP}/device/nexell/secure/bl_mon.img \
		"-m 0x40200 -b 3 -p ${DEV_PORTNUM} -m 0x1E0200 -b 3 -p ${DEV_PORTNUM} -m 0x60200 -b 3 -p ${DEV_PORTNUM}"

	file_size=35840
	dd if=${TOP}/device/nexell/secure/loader-emmc.img of=${TOP}/device/nexell/secure/fip-loader-usb.bin seek=0 bs=1
	let pos=pos+file_size
	file_size=28672
	dd if=${TOP}/device/nexell/secure/bl_mon.img of=${TOP}/device/nexell/secure/fip-loader-usb.bin seek=${pos} bs=1
	let pos=pos+file_size
	dd if=${TOP}/device/nexell/secure/bootloader.img of=${TOP}/device/nexell/secure/fip-loader-usb.bin seek=${pos} bs=1

	if [ "${MEMSIZE}" == "2GB" ]; then
		load_addr="63c00000"
		start_addr="63c00000"
	elif [ "${MEMSIZE}" == "1GB" ]; then
		load_addr="83c00000"
		start_addr="83c00000"
	fi

	python ${TOP}/device/nexell/tools/nsihtxtmod.py ${DEVICE_DIR} ${TOP}/device/nexell/secure/fip-loader-usb.bin $load_addr $start_addr
	python ${TOP}/device/nexell/tools/nsihbingen.py ${DEVICE_DIR}/nsih-usbdownload.txt ${DEVICE_DIR}/nsih-usbdownload.bin

	cp ${DEVICE_DIR}/nsih-usbdownload.bin ${TOP}/device/nexell/secure/fip-loader-usb.img
	dd if=${TOP}/device/nexell/secure/fip-loader-usb.bin >> ${TOP}/device/nexell/secure/fip-loader-usb.img
fi

if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_KERNEL}" == "true" ]; then
    if [ "${QUICKBOOT}" == "true" ]; then
            if [ "${BUILD_SKIP_RECOVERY_KERNEL}" == "false" ]; then
                print_build_info kernel_recovery
                build_kernel ${KERNEL_DIR} ${TARGET_SOC} ${BOARD_NAME} s5p4418_con_svma_nougat_defconfig ${CROSS_COMPILE}
                if [ ! -d ${OUT_DIR} ]; then
                    mkdir -p ${OUT_DIR}
                fi
                cp ${RECOVERY_KERNEL_IMG} ${OUT_DIR}/kernel_recovery
            fi
        print_build_info kernel_Quickboot
        build_kernel ${KERNEL_DIR} ${TARGET_SOC} ${BOARD_NAME} s5p4418_con_svma_nougat_quickboot_defconfig ${CROSS_COMPILE}
        if [ ! -d ${OUT_DIR} ]; then
            mkdir -p ${OUT_DIR}
        fi
        cp ${KERNEL_IMG} ${OUT_DIR}/kernel && \
        cp ${DTB_IMG} ${OUT_DIR}/2ndbootloader
    else
        build_kernel ${KERNEL_DIR} ${TARGET_SOC} ${BOARD_NAME} s5p4418_con_svma_nougat_defconfig ${CROSS_COMPILE}
        if [ ! -d ${OUT_DIR} ]; then
            mkdir -p ${OUT_DIR}
        fi
        cp ${KERNEL_IMG} ${OUT_DIR}/kernel && \
        cp ${DTB_IMG} ${OUT_DIR}/2ndbootloader
    fi

fi

if [ "${BUILD_KERNEL}" == "true" ]; then
    ${DTIMGE_TOOL} create ${OUT_DIR}/dtb.img \
     ${TOP}/device/nexell/kernel/kernel-4.4.x/arch/arm/boot/dts/s5p4418-con_svma-rev00.dtb --id=0 \
     ${TOP}/device/nexell/kernel/kernel-4.4.x/arch/arm/boot/dts/s5p4418-con_svma-rev01.dtb --id=1
fi


if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_MODULE}" == "true" ]; then
    build_module ${KERNEL_DIR} ${TARGET_SOC} ${CROSS_COMPILE}
fi

test -d ${OUT_DIR} && test -f ${DEVICE_DIR}/bootloader && cp ${DEVICE_DIR}/bootloader ${OUT_DIR}

if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_ANDROID}" == "true" ] || [ "${BUILD_DIST}" == "true" ]; then
    if [ "${QUICKBOOT}" == "true" ]; then
        # cp ${DEVICE_DIR}/quickboot/* ${DEVICE_DIR}
        cp ${DEVICE_DIR}/aosp_con_svma_quickboot.mk ${DEVICE_DIR}/aosp_con_svma.mk
    else
        cp ${DEVICE_DIR}/aosp_con_svma_normalboot.mk ${DEVICE_DIR}/aosp_con_svma.mk
    fi

    rm -rf ${OUT_DIR}/system
    rm -rf ${OUT_DIR}/root
    rm -rf ${OUT_DIR}/data
    generate_key ${BOARD_NAME}
    test -f ${DEVICE_DIR}/domain.te && cp ${DEVICE_DIR}/domain.te ${TOP}/system/sepolicy
    test -f ${DEVICE_DIR}/app.te && cp ${DEVICE_DIR}/app.te ${TOP}/system/sepolicy

    build_android ${TARGET_SOC} ${BOARD_NAME} ${BUILD_TAG}

#    test -d ${DEVICE_DIR}/apk_install && install_zh_apk
#    test -d ${DEVICE_DIR}/nx_3d_avm && install_avm_apk
fi


# u-boot envs
if [ -f ${UBOOT_DIR}/u-boot.bin ]; then
    if [  "${QUICKBOOT}" == "true" ]; then
        UBOOT_BOOTCMD=$(make_uboot_bootcmd_svm \
            ${PARTMAP_FILE} \
            ${UBOOT_LOAD_ADDR} \
            2048 \
            ${KERNEL_IMG} \
            ${OUT_DIR}/ramdisk.img \
            "boot:emmc")
    else
		UBOOT_BOOTCMD="aboot load_mmc 5000 40008000 48000000;dtimg load_mmc 23800 49000000 \$\{board_rev\};bootz 40008000 0x48000000:\$\{ramdisk_size\} 0x49000000"
    fi

if [ "${MEMSIZE}" == "2GB" ]; then
    UBOOT_RECOVERYCMD=$(make_uboot_recoverycmd \
					${PARTMAP_FILE} \
                    0x40008000 \
                    0x48000000 \
                    0x49000000 \
                    ${OUT_DIR}/ramdisk-recovery.img)
elif [ "${MEMSIZE}" == "1GB" ]; then
    UBOOT_RECOVERYCMD=$(make_uboot_recoverycmd \
					${PARTMAP_FILE} \
                    0x71008000 \
                    0x79000000 \
                    0x7A000000 \
                    ${OUT_DIR}/ramdisk-recovery.img)
fi

if [ "${QUICKBOOT}" == "true" ]; then
    UBOOT_BOOTARGS="console=ttyAMA3,115200n8 loglevel=7 printk.time=1 androidboot.hardware=con_svma androidboot.console=ttyAMA3 androidboot.serialno=0123456789ABCDEF root=\/dev\/mmcblk0p2 rw rootfstype=ext4 rootwait init=\/sbin\/nx_init quiet androidboot.selinux=permissive"
else
    UBOOT_BOOTARGS="console=ttyAMA3,115200n8 loglevel=7 printk.time=1 androidboot.hardware=con_svma androidboot.console=ttyAMA3 androidboot.serialno=0123456789ABCDEF quiet androidboot.selinux=permissive"
fi
    RECOVERY_BOOTARGS="console=ttyAMA3,115200n8 loglevel=7 printk.time=1 androidboot.hardware=con_svma androidboot.console=ttyAMA3 androidboot.serialno=0123456789ABCDEF androidboot.selinux=permissive"
    SPLASH_SOURCE="mmc"
    SPLASH_OFFSET="0x2e4200"

    echo "UBOOT_BOOTCMD ==> ${UBOOT_BOOTCMD}"
    echo "UBOOT_BOOTARGS ==> ${UBOOT_BOOTARGS}"
    echo "UBOOT_RECOVERYCMD ==> ${UBOOT_RECOVERYCMD}"
    echo "UBOOT_RECOVERYARGS ==> ${RECOVERY_BOOTARGS}"

    pushd `pwd`
    cd ${UBOOT_DIR}
    build_uboot_env_param ${CROSS_COMPILE} "${UBOOT_BOOTCMD}" "${UBOOT_BOOTARGS}" "${RECOVERY_BOOTARGS}" "${SPLASH_SOURCE}" "${SPLASH_OFFSET}" "${UBOOT_RECOVERYCMD}"
    popd
fi

# make bootloader
echo "make bootloader"
bl1=${BL1_DIR}/bl1-${TARGET_SOC}/out/bl1-emmcboot.bin
loader=${TOP}/device/nexell/secure/loader-emmc.img
secure=${TOP}/device/nexell/secure/bl_mon.img
nonsecure=${TOP}/device/nexell/secure/bootloader.img
param=${UBOOT_DIR}/params.bin
boot_logo=${DEVICE_DIR}/logo.bmp
out_file=${DEVICE_DIR}/bootloader

if [ -f ${bl1} ] && [ -f ${loader} ] && [ -f ${secure} ] && [ -f ${nonsecure} ] && [ -f ${param} ] && [ -f ${boot_logo} ]; then
	BOOTLOADER_PARTITION_SIZE=$(get_partition_size ${DEVICE_DIR}/partmap.txt bootloader)
	make_bootloader \
		${BOOTLOADER_PARTITION_SIZE} \
		${bl1} \
		65536 \
		${loader} \
		262144 \
		${secure} \
		1966080 \
		${nonsecure} \
		3014656 \
		${param} \
		3031040 \
		${boot_logo} \
		${out_file}

	test -d ${OUT_DIR} && cp ${DEVICE_DIR}/bootloader ${OUT_DIR}
fi

if [ "${BUILD_KERNEL}" == "true" ]; then
	test -f ${OUT_DIR}/ramdisk.img && \
		make_android_bootimg \
			${KERNEL_IMG} \
			${DTB_IMG} \
			${OUT_DIR}/ramdisk.img \
			${OUT_DIR}/boot.img \
			2048 \
			"buildvariant=${BUILD_TAG}"
fi

post_process ${TARGET_SOC} \
    ${PARTMAP_FILE} \
    ${RESULT_DIR} \
    ${BL1_DIR}/bl1-${TARGET_SOC}/out \
    ${TOP}/device/nexell/secure \
    ${UBOOT_DIR} \
    ${KERNEL_DIR}/arch/arm/boot \
    ${KERNEL_DIR}/arch/arm/boot/dts \
    ${OUT_DIR} \
    con_svma

cp -f ${TOP}/device/nexell/con_svma/boot_by_usb.sh ${RESULT_DIR}

cp -f ${OUT_DIR}/dtb.img ${RESULT_DIR}

make_ext4_recovery_image \
    ${OUT_DIR}/kernel \
    ${KERNEL_DIR}/arch/arm/boot/dts/s5p4418-con_svma-rev00.dtb \
    ${OUT_DIR}/ramdisk-recovery.img \
    67108864 \
    ${RESULT_DIR}

if [ "${BUILD_DIST}" == "true" ]; then
    build_dist ${TARGET_SOC} ${BOARD_NAME} ${BUILD_TAG}
    cp ${TOP}/out/dist/aosp_con_svma-target_files-eng.$(whoami).zip ${RESULT_DIR}/target_files.zip
    if [ "${OTA_INCREMENTAL}" == "true" ]; then
        test -z ${OTA_PREVIOUS_FILE} && echo "No valid previous target.zip(${OTA_PREVIOUS_FILE})" || \
        ${TOP}/build/tools/releasetools/ota_from_target_files \
            -i ${OTA_PREVIOUS_FILE} ${RESULT_DIR}/target_files.zip \
            ${RESULT_DIR}/ota_update.zip
    else
        ${TOP}/build/tools/releasetools/ota_from_target_files \
            ${RESULT_DIR}/target_files.zip ${RESULT_DIR}/ota_update.zip
    fi
fi

make_build_info ${RESULT_DIR}


if [ -f "${KERNEL_IMG}" ];then
cp -af ${KERNEL_IMG} ${RESULT_DIR}
fi

