ifneq ($(TARGET_BUILD_VARIANT), user)
  ifeq (,$(filter aosp_%, $(TARGET_PRODUCT))) # Skip aosp target product
    PRODUCT_PACKAGES_DEBUG += \
      Gyotaku

      BOARD_SEPOLICY_DIRS += device/google/gs-common/gyotaku_app/sepolicy/

      # Pixel 5a (barbet) does not support Pixel dump
      ifeq (,$(filter barbet%,$(TARGET_PRODUCT)))
        PRODUCT_PACKAGES_DEBUG += dump_gyotaku
        BOARD_SEPOLICY_DIRS += device/google/gs-common/gyotaku_app/dump
      endif
  endif
endif
