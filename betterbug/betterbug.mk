# When neither AOSP nor factory targets
ifeq (,$(filter aosp_% factory_%, $(TARGET_PRODUCT)))
  PRODUCT_PACKAGES += BetterBugStub
  PRODUCT_PACKAGES_DEBUG += $(RELEASE_PACKAGE_BETTER_BUG)
endif

PRODUCT_PUBLIC_SEPOLICY_DIRS += device/google/gs-common/betterbug/sepolicy/product/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/gs-common/betterbug/sepolicy/product/private
