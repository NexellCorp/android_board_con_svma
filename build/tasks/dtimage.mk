ifneq ($(filter con_svma, $(TARGET_DEVICE)),)
ifneq ($(TARGET_NO_DTIMAGE), true)

MKDTIMG := device/nexell/tools/mkdtimg
DTB_DIR := device/nexell/kernel/kernel-4.4.x/arch/arm/boot/dts
DTB_REV00 := $(DTB_DIR)/s5p4418-con_svma-rev00.dtb
DTB_REV01 := $(DTB_DIR)/s5p4418-con_svma-rev01.dtb

$(PRODUCT_OUT)/dtb.img: $(DTB_REV00)
	$(MKDTIMG) create $@ \
	$(DTB_REV00) --id=0 \
	$(DTB_REV01) --id=1


droidcore: $(PRODUCT_OUT)/dtb.img


# Images will be packed into target_files zip.
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/dtb.img

endif
endif
