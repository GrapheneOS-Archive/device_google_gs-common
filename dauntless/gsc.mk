# Dauntless
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/dauntless/sepolicy
ifneq ($(wildcard vendor),)
PRODUCT_SOONG_NAMESPACES += vendor/google_nos/init/dauntless

PRODUCT_PACKAGES += \
    citadeld \
    citadel_updater \
    android.hardware.weaver-service.citadel \
    android.hardware.authsecret-service.citadel \
    android.hardware.oemlock-service.citadel \
    init_citadel \
    android.hardware.strongbox_keystore.xml \
    android.hardware.security.keymint-service.citadel \
    dump_gsc.sh

# USERDEBUG ONLY: Install test packages
PRODUCT_PACKAGES_DEBUG += citadel_integration_tests \
                          pwntest \
                          nugget_targeted_tests \
                          CitadelProvision \
                          nugget_aidl_test_weaver
endif
