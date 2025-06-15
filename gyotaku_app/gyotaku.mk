ifneq ($(TARGET_BUILD_VARIANT), user)
  ifeq (,$(filter aosp_%, $(TARGET_PRODUCT))) # Skip aosp target product
      BOARD_SEPOLICY_DIRS += device/google/gs-common/gyotaku_app/sepolicy/

      # Pixel 5a (barbet) does not support Pixel dump
      ifeq (,$(filter barbet%,$(TARGET_PRODUCT)))
        BOARD_SEPOLICY_DIRS += device/google/gs-common/gyotaku_app/dump
      endif
  endif
endif
