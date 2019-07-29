#!/bin/bash

set -e

DEV_PORTNUM=0
MEMSIZE="2GB"
PAGESIZE=4096
OTA_AB_UPDATE=true

ADDRESS=0x93c00000
if [ "${MEMSIZE}" == "2GB" ]; then
    ADDRESS=0x63c00000
    UBOOT_LOAD_ADDR=0x40008000
    UBOOT_IMG_LOAD_ADDR=0x43c00000
    UBOOT_IMG_JUMP_ADDR=0x43c00000

elif [ "${MEMSIZE}" == "1GB" ]; then
    ADDRESS=0x83c00000
    UBOOT_LOAD_ADDR=0x71008000
    UBOOT_IMG_LOAD_ADDR=0x74c00000
    UBOOT_IMG_JUMP_ADDR=0x74c00000
fi


CROSS_COMPILE="arm-eabi-"
PARTMAP_TXT="partmap_legacy.txt"

if [ "${OTA_AB_UPDATE}" == "true" ]; then
    PARTMAP_TXT="partmap_AB_update.txt"
fi

DEVICE_DIR=${TOP}/device/nexell/con_svma
KERNEL_IMG=${KERNEL_DIR}/arch/arm/boot/zImage
DTB_DIR=${KERNEL_DIR}/arch/arm/boot/dts
DTIMG_ARG="${DTB_DIR}/s5p4418-con_svma-rev00.dtb --id=0 "
DTIMG_ARG+="${DTB_DIR}/s5p4418-con_svma-rev01.dtb --id=1 "

#NxQuickRear arguments (tw9900, tp2825)
NXQUICKREAR_ARGS=("nx_cam.m=-m1 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r704x480 nx_cam.end")
NXQUICKREAR_ARGS+=("nx_cam.m=-m6 nx_cam.b=-b1 nx_cam.c=-c26 nx_cam.r=-r1280x720 nx_cam.end")


function run_clean_packages()
{
    if [ "${BUILD_DIST}" == "true" ]; then
        rm -rf ${OUT_DIR}/obj/PACKAGING/
    fi
}

function run_bl1_build()
{
    if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_BL1}" == "true" ]; then
        build_bl1_s5p4418 ${BL1_DIR}/bl1-${TARGET_SOC} nxp4330 con_svma 0
    fi
}

function run_uboot_build()
{
    if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_UBOOT}" == "true" ]; then
        build_uboot ${UBOOT_DIR} ${TARGET_SOC} ${BOARD_NAME} ${CROSS_COMPILE}
        gen_third ${TARGET_SOC} ${UBOOT_DIR}/u-boot.bin \
            ${UBOOT_IMG_LOAD_ADDR} ${UBOOT_IMG_JUMP_ADDR} \
            ${TOP}/device/nexell/secure/bootloader.img
    fi
}

function run_secure_build()
{
    if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_SECURE}" == "true" ] || [ "${BUILD_UBOOT}" == "true" ]; then
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
}

function run_kernel_build()
{
    CROSS_COMPILE_KERNEL=arm-linux-androideabi-
    if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_KERNEL}" == "true" ]; then
        build_kernel ${KERNEL_DIR} ${TARGET_SOC} ${BOARD_NAME} s5p4418_con_svma_pie_defconfig ${CROSS_COMPILE_KERNEL}
        if [ ! -d ${OUT_DIR} ]; then
            mkdir -p ${OUT_DIR}
        fi
        cp -af ${KERNEL_IMG} ${DEVICE_DIR}/kernel
        cp -af ${KERNEL_IMG} ${OUT_DIR}/kernel
    fi
}


function run_dtb_build()
{
    CROSS_COMPILE_KERNEL=arm-linux-androideabi-
    if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_DTB}" == "true" ]; then
        if [ ! -f ${DEVICE_DIR}/kernel ]; then
            echo "ERROR: kernel build must be done before dtb build"
            exit 0
        fi
        build_dtb ${KERNEL_DIR} ${TARGET_SOC} ${CROSS_COMPILE_KERNEL}
        echo ${DTIMG_ARG}
        if [ ! -d ${OUT_DIR} ]; then
            mkdir -p ${OUT_DIR}
        fi
        ${TOP}/device/nexell/tools/mkdtimg create ${DEVICE_DIR}/dtbo.img ${DTIMG_ARG}
        cp -af ${DEVICE_DIR}/dtbo.img ${OUT_DIR}/dtbo.img
    fi
}

function run_android_build()
{
    if [ "${BUILD_DIST}" == "false" ]; then
        if [ "${BUILD_ALL}" == "true" ] || [ "${BUILD_ANDROID}" == "true" ]; then
            rm -rf ${OUT_DIR}/system
            rm -rf ${OUT_DIR}/root
            rm -rf ${OUT_DIR}/data
            generate_key ${BOARD_NAME}
            build_android ${TARGET_SOC} "${BOARD_NAME}_auto" ${BUILD_TAG}
        fi
    fi
}

function run_dist_build()
{
    if [ "${BUILD_DIST}" == "true" ]; then
        build_dist ${TARGET_SOC} ${BOARD_NAME} ${BUILD_TAG}
    fi
}

function run_make_uboot_env()
{
    # u-boot envs
    echo "make u-boot env"
    local UBOOT_BOOTCMD
    if [ -f ${UBOOT_DIR}/u-boot.bin ]; then
        test -f ${UBOOT_DIR}/u-boot.bin && \
            make_uboot_bootcmd ${DEVICE_DIR}/${PARTMAP_TXT} \
                   ${UBOOT_LOAD_ADDR} \
                   ${PAGESIZE} \
                   ${KERNEL_IMG} \
                    0x49000000 \
                   ${DEVICE_DIR}/ramdisk-not-used \
                   "boot_a:emmc" \
                   "boot_b:emmc" \
                   UBOOT_BOOTCMD

        UBOOT_RECOVERYCMD="ext4load mmc 0:6 0x49000000 recovery.dtb; ext4load mmc 0:6 0x40008000 recovery.kernel; ext4load mmc 0:6 0x48000000 ramdisk-recovery.img; bootz 40008000 0x48000000:2d0f8f 0x49000000"

        UBOOT_BOOTARGS='console=ttyAMA3,115200n8 loglevel=7 printk.time=1 androidboot.hardware=con_svma androidboot.console=ttyAMA3 androidboot.serialno=0123456789abcdef '
        UBOOT_BOOTARGS+=' root=\/dev\/mmcblk0p2 rw rootwait rootfstype=ext4 init=\/sbin\/nx_init skip_initramfs vmalloc=384M '
        UBOOT_BOOTARGS+=' product_part=\/dev\/mmcblk0p13 '
        UBOOT_BOOTARGS+='blkdevparts=mmcblk0:65024@512(bl1),'
        UBOOT_BOOTARGS+='4915200@66048(bootloader_a),4915200@5046784(bootloader_b),'
        UBOOT_BOOTARGS+='62914560@11075584(boot_a),62914560@75038720(boot_b),'
        UBOOT_BOOTARGS+='3145728@139001856(dtbo_a),3145728@143196160(dtbo_b),'
        UBOOT_BOOTARGS+='1073741824@147390464(system_a),1073741824@1222180864(system_b),'
        UBOOT_BOOTARGS+='268435456@2296971264(vendor_a),268435456@2566455296(vendor_b),'
        UBOOT_BOOTARGS+='1048576@2835939328(misc),'
        UBOOT_BOOTARGS+='3145728@2838036480(product),'
        UBOOT_BOOTARGS+='305237797168@2842230784(userdata)'
        SPLASH_SOURCE="mmc"
        SPLASH_OFFSET="0x2e4200"

        echo -e "----------------------------------------------------"
        echo -e "UBOOT_BOOTCMD_A = ${UBOOT_BOOTCMD[0]}"
        echo -e "UBOOT_BOOTCMD_B = ${UBOOT_BOOTCMD[1]}"
        echo -e "----------------------------------------------------"
        echo -e "UBOOT_RECOVERYCMD ==> ${UBOOT_RECOVERYCMD}\n"

        pushd `pwd`
        cd ${UBOOT_DIR}
        build_uboot_env_param ${CROSS_COMPILE} "UBOOT_BOOTCMD[@]" "${UBOOT_BOOTARGS}" "${SPLASH_SOURCE}" "${SPLASH_OFFSET}" "${UBOOT_RECOVERYCMD}" "NXQUICKREAR_ARGS[@]"
        popd
    fi
}

function run_make_bootloader()
{
    # make bootloader
    echo "make bootloader"
    loader=${TOP}/device/nexell/secure/loader-emmc.img
    secure=${TOP}/device/nexell/secure/bl_mon.img
    nonsecure=${TOP}/device/nexell/secure/bootloader.img
    param=${UBOOT_DIR}/params.bin
    boot_logo=${DEVICE_DIR}/logo.bmp
    out_file=${DEVICE_DIR}/bootloader
    #65536=(0x10000)
    offset_secure=262144        #0x40000
    offset_nonsecure=1966080    #0x1E0000
    offset_param=3014656        #0x2E0000
    offset_bootlogo=3031040     #0x2E4000

    if [ "${OTA_AB_UPDATE}" == "true" ]; then
        offset_secure=196608        # 0x40000 - 0x10000 = 0x 30000
        offset_nonsecure=1900544    #0x1E0000 - 0x10000 = 0x1D0000
        offset_param=2949120        #0x2E0000 - 0x10000 = 0x2D0000
        offset_bootlogo=2965504     #0x2E4000 - 0x10000 = 0x2D4000
    fi

    if [ -f ${loader} ] && [ -f ${secure} ] && [ -f ${nonsecure} ] && [ -f ${param} ] && [ -f ${boot_logo} ]; then
        BOOTLOADER_PARTITION_SIZE=$(get_partition_size ${DEVICE_DIR}/${PARTMAP_TXT} bootloader_a)
        make_bootloader \
            ${BOOTLOADER_PARTITION_SIZE} \
            ${loader} \
            ${offset_secure} \
            ${secure} \
            ${offset_nonsecure} \
            ${nonsecure} \
            ${offset_param} \
            ${param} \
            ${offset_bootlogo} \
            ${boot_logo} \
            ${out_file}

        test -d ${OUT_DIR} && cp ${DEVICE_DIR}/bootloader ${OUT_DIR}
    fi
}

function run_make_android_bootimg()
{
    make_android_bootimg \
        ${KERNEL_IMG} \
        ${DEVICE_DIR}/ramdisk-not-used \
        ${OUT_DIR}/boot.img \
        ${PAGESIZE} \
        "buildvariant=${BUILD_TAG}"
}

function run_post_process()
{
    post_process ${TARGET_SOC} \
        ${DEVICE_DIR}/${PARTMAP_TXT} \
        ${RESULT_DIR} \
        ${BL1_DIR}/bl1-${TARGET_SOC}/out \
        ${TOP}/device/nexell/secure \
        ${UBOOT_DIR} \
        ${KERNEL_DIR}/arch/arm/boot \
        ${KERNEL_DIR}/arch/arm/boot/dts \
        67108864 \
        ${OUT_DIR} \
        con_svma \
        ${DEVICE_DIR}/logo.bmp
}

function run_gen_boot_usb()
{
    gen_boot_usb_script_4418 nxp4330 0xffff0000 ${RESULT_DIR}
}
