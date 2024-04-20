include device/google/gs-common/touch/predump/predump_touch.mk

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/touch/gti/predump_sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/touch/gti/ical/sepolicy

PRODUCT_PACKAGES += predump_gti0.sh
PRODUCT_PACKAGES += touch_gti_ical
