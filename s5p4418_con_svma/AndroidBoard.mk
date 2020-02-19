LOCAL_PATH := $(call my-dir)

$(info "======= AndroidBoard.mk enter =========")

include vendor/nexell/common/kernel.mk
include vendor/nexell/common/dtbo.mk
include vendor/nexell/common/bl1_s5p4418.mk
include vendor/nexell/common/bl2.mk
include vendor/nexell/common/armv7-dispacher.mk
include vendor/nexell/common/uboot.mk

$(info "======= AndroidBoard.mk exit ==========")

