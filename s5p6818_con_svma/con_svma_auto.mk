
PRODUCT_CAR := true


$(call inherit-product, device/nexell/con_svma/common/automotive/auto.mk)

PRODUCT_NAME := s5p6818_con_svma_auto
PRODUCT_DEVICE := s5p6818_con_svma
PRODUCT_BRAND := con_svma
PRODUCT_MODEL := con_svma auto
PRODUCT_MANUFACTURER := Nexell
PRODUCT_HARDWARE := con_svma


BOARD_PLAT_PUBLIC_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/private


# automatically called
-include device/nexell/con_svma/common/device_common.mk

DEVICE_MANIFEST_FILE := device/nexell/con_svma/common/manifest_car.xml

-include device/nexell/con_svma/s5p6818_con_svma/common.mk

DEVICE_PACKAGE_OVERLAYS := device/nexell/con_svma/common/overlay_car

$(call inherit-product-if-exists, device/nexell/con_svma/common/automotive/nexell_connectivity.mk)
$(call inherit-product-if-exists, device/nexell/app/svm_daemon/svm-daemon.mk)
$(call inherit-product-if-exists, device/nexell/app/nx_backgear_service/nxbackgearservice.mk)
$(call inherit-product-if-exists, device/nexell/app/nx_rearcam_app/nxrearcam.mk)
$(call inherit-product-if-exists, device/nexell/app/nx_svm_app/nxsvm.mk)
$(call inherit-product-if-exists, device/nexell/app/nx_svm_autocalibration/nxsvmautocalibration.mk)
$(call inherit-product-if-exists, device/nexell/app/nx_svm_demo/nxsvmdemo.mk)
$(call inherit-product-if-exists, device/nexell/app/nx_svm_viewmode_editor/nxsvmviewmodeeditor.mk)

PRODUCT_PACKAGES += \
    nx_init

PRODUCT_PACKAGES += \
    NxQuickRearCam




