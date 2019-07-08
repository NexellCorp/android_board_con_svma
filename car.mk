# lighter version of packages/services/Car/car_product/build/car.mk
#
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += packages/services/Car/car_product/sepolicy/private

PRODUCT_PACKAGES += \
    SystemUI \
    Bluetooth

PRODUCT_PACKAGES += \
    clatd \
    clatd.conf \
    pppd

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.conf:system/etc/audio_effects.conf \
    packages/services/Car/car_product/preloaded-classes-car:system/etc/preloaded-classes

PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=unknown \
    persist.bluetooth.enablenewavrcp=false

$(call inherit-product, device/sample/products/location_overlay.mk)
$(call inherit-product-if-exists, frameworks/base/data/fonts/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/dancing-script/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/carrois-gothic-sc/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/coming-soon/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/cutive-mono/fonts.mk)
$(call inherit-product-if-exists, external/noto-fonts/fonts.mk)
$(call inherit-product-if-exists, external/roboto-fonts/fonts.mk)
$(call inherit-product-if-exists, external/hyphenation-patterns/patterns.mk)
$(call inherit-product-if-exists, frameworks/base/data/keyboards/keyboards.mk)
$(call inherit-product-if-exists, frameworks/webview/chromium/chromium.mk)

# $(call inherit-product, packages/services/Car/car_product/build/car_base.mk)

PRODUCT_PACKAGE_OVERLAYS += packages/services/Car/car_product/overlay

PRODUCT_PACKAGES += \
    FusedLocation \
    InputDevices \
    KeyChain \
    Keyguard \
    ManagedProvisioning \
    PacProcessor \
    libpac \
    ProxyHandler \
    ExternalStorageProvider \
    atrace \
    libandroidfw \
    libaudiopreprocessing \
    libaudioutils \
    libfilterpack_imageproc \
    libgabi++ \
    libmdnssd \
    libnfc_ndef \
    libpowermanager \
    libspeexresampler \
    libstagefright_soft_aacdec \
    libstagefright_soft_aacenc \
    libstagefright_soft_amrdec \
    libstagefright_soft_amrnbenc \
    libstagefright_soft_amrwbenc \
    libstagefright_soft_avcdec \
    libstagefright_soft_avcenc \
    libstagefright_soft_flacdec \
    libstagefright_soft_flacenc \
    libstagefright_soft_g711dec \
    libstagefright_soft_gsmdec \
    libstagefright_soft_hevcdec \
    libstagefright_soft_mp3dec \
    libstagefright_soft_mpeg2dec \
    libstagefright_soft_mpeg4dec \
    libstagefright_soft_mpeg4enc \
    libstagefright_soft_opusdec \
    libstagefright_soft_rawdec \
    libstagefright_soft_vorbisdec \
    libstagefright_soft_vpxdec \
    libstagefright_soft_vpxenc \
    libvariablespeed \
    libwebrtc_audio_preprocessing \
    mdnsd \
    requestsync \
    wifi-service \
    A2dpSinkService \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:system/etc/permissions/android.hardware.type.automotive.xml

PRODUCT_COPY_FILES += \
    packages/services/Car/car_product/build/default-car-permissions.xml:system/etc/default-permissions/default-car-permissions.xml

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Girtab.ogg \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.alarm_alert=Oxygen.ogg

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

# Automotive specific packages
PRODUCT_PACKAGES += \
    CarService \
    CarTrustAgentService \
    CarDialerApp \
    CarRadioApp \
    OverviewApp \
    CarLauncher \
    CarLensPickerApp \
    LocalMediaPlayer \
    CarMediaApp \
    CarMessengerApp \
    CarHvacApp \
    CarMapsPlaceholder \
    CarLatinIME \
    CarSettings \
    CarUsbHandler \
    android.car \
    car-frameworks-service \
    com.android.car.procfsinspector \
    libcar-framework-service-jni \

# System Server components
PRODUCT_SYSTEM_SERVER_JARS += car-frameworks-service

# Boot animation
PRODUCT_COPY_FILES += \
    packages/services/Car/car_product/bootanimations/bootanimation-832.zip:system/media/bootanimation.zip

PRODUCT_PROPERTY_OVERRIDES += \
    fmas.spkr_6ch=35,20,110 \
    fmas.spkr_2ch=35,25 \
    fmas.spkr_angles=10 \
    fmas.spkr_sgain=0 \
    media.aac_51_output_enabled=true

PRODUCT_LOCALES := en_US af_ZA am_ET ar_EG bg_BG bn_BD ca_ES cs_CZ da_DK de_DE el_GR en_AU en_GB en_IN es_ES es_US et_EE eu_ES fa_IR fi_FI fr_CA fr_FR gl_ES hi_IN hr_HR hu_HU hy_AM in_ID is_IS it_IT iw_IL ja_JP ka_GE km_KH ko_KR ky_KG lo_LA lt_LT lv_LV km_MH kn_IN mn_MN ml_IN mk_MK mr_IN ms_MY my_MM ne_NP nb_NO nl_NL pl_PL pt_BR pt_PT ro_RO ru_RU si_LK sk_SK sl_SI sr_RS sv_SE sw_TZ ta_IN te_IN th_TH tl_PH tr_TR uk_UA vi_VN zh_CN zh_HK zh_TW zu_ZA en_XA ar_XB

# should add to BOOT_JARS only once
ifeq (,$(INCLUDED_ANDROID_CAR_TO_PRODUCT_BOOT_JARS))
PRODUCT_BOOT_JARS += \
    android.car

INCLUDED_ANDROID_CAR_TO_PRODUCT_BOOT_JARS := yes
endif
