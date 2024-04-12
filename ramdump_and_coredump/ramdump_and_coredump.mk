PRODUCT_PACKAGES += \
  sscoredump \
  SSRestartDetector

PRODUCT_PACKAGES_DEBUG += \
    dump_ramdump \
    ramdump \
    RamdumpUploader

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/ramdump_and_coredump/sepolicy

# sscoredump
PRODUCT_PROPERTY_OVERRIDES += vendor.debug.ssrdump.type=sscoredump
PRODUCT_SOONG_NAMESPACES += vendor/google/tools/subsystem-coredump
