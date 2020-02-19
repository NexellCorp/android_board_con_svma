PRODUCT_COPY_FILES += \
  device/nexell/con_svma/common/iproxy.sh:system/bin/iproxy.sh

# carlife with android phone
PRODUCT_PACKAGES += \
  libbdcl \
  libdiagnose_usb_bdcl \
  bdcl

# carlife with iphone
PRODUCT_PACKAGES += \
  libusb1.0 \
  libcnary \
  libplist \
  libplist++ \
  plist_cmp \
  plist_test \
  plist_util \
  libusbmuxdcommon \
  libusbmuxd \
  iproxy \
  libcrypto_openssl \
  libimobilecommon \
  libmobiledevice \
  ideviceinfo \
  idevicename \
  idevicepair \
  idevicesyslog \
  idevice_id \
  idevicebackup \
  idevicebackup2 \
  ideviceimagemounter \
  idevicescreenshot \
  ideviceenterrecovery \
  idevicedate \
  ideviceprovision \
  idevicedebugserverproxy \
  idevicediagnostics \
  idevicedebug \
  idevicenotificationproxy \
  idevicecrashreport \
  usbmuxd \
  libzip \
  ideviceinstaller
