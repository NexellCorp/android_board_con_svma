#!/bin/bash

set -e

TOP=`pwd`

source ${TOP}/device/nexell/tools/common.sh
source ${TOP}/device/nexell/tools/dir.sh
source ${TOP}/device/nexell/tools/make_build_info.sh

parse_args $@
print_args
setup_toolchain
export_work_dir

DEVICE_DIR=${TOP}/device/nexell/con_svma
OUT_DIR=${TOP}/out/target/product/con_svma

rm -f ${DEVICE_DIR}/BoardConfig.mk
ln -s ${DEVICE_DIR}/BoardConfig_${TARGET_SOC}.mk ${DEVICE_DIR}/BoardConfig.mk
rm -f ${DEVICE_DIR}/soc.mk
ln -s  ${DEVICE_DIR}/soc_${TARGET_SOC}.mk ${DEVICE_DIR}/soc.mk
source ${DEVICE_DIR}/build_${TARGET_SOC}.sh $@

run_clean_packages
run_bl1_build
run_uboot_build
run_secure_build
run_kernel_build
run_dtb_build
run_android_build
run_make_uboot_env
run_make_bootloader
run_make_android_bootimg
run_dist_build
run_post_process
run_gen_boot_usb
