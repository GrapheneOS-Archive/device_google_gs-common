PRODUCT_PACKAGES += \
  sscoredump \

PRODUCT_PACKAGES_DEBUG += \
    dump_ramdump \
    ramdump \

# When neither AOSP nor factory targets
ifeq (,$(filter aosp_% factory_%, $(TARGET_PRODUCT)))
  PRODUCT_PACKAGES += SSRestartDetector
  PRODUCT_PACKAGES_DEBUG += RamdumpUploader
endif

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/ramdump_and_coredump/sepolicy

# sscoredump
PRODUCT_PROPERTY_OVERRIDES += vendor.debug.ssrdump.type=sscoredump
PRODUCT_SOONG_NAMESPACES += vendor/google/tools/subsystem-coredump
