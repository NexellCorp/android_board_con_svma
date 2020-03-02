LOCAL_PATH := $(call my-dir)

$(info "======= AndroidBoard.mk enter =========")

include vendor/nexell/build/kernel.mk
include vendor/nexell/build/dtbo.mk
include vendor/nexell/build/bl1_s5p4418.mk
include vendor/nexell/build/bl2.mk
include vendor/nexell/build/armv7-dispacher.mk
include vendor/nexell/build/uboot.mk
include vendor/nexell/build/fip_s5p4418.mk
include vendor/nexell/build/gen_bootloader.mk

$(info "======= AndroidBoard.mk exit ==========")

