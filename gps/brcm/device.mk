BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/gps/brcm/sepolicy

ifeq (,$(call soong_config_get,gpssdk,sdkv1))
    $(call soong_config_set,gpssdk,sdkv1,false)
endif
ifeq (,$(call soong_config_get,gpssdk,gpsmcuversion))
    $(call soong_config_set,gpssdk,gpsmcuversion,gpsv2_$(TARGET_BUILD_VARIANT))
endif

PRODUCT_PACKAGES += \
	android.hardware.location.gps.prebuilt.xml
