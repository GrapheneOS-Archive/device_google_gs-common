
DEVICE_MANIFEST_FILE += device/google/gs-common/audio/aidl/manifest.xml

PRODUCT_PACKAGES += \
    libvisualizeraidl \
    libbundleaidl \
    libreverbaidl \
    libdynamicsprocessingaidl \
    libloudnessenhanceraidl \
    libdownmixaidl \
    libhapticgeneratoraidl \

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/audio/sepolicy/aidl
ifeq ($(AUDIO_USE_DPTX_SEPOLICY),true)
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/audio/sepolicy/hdmi_audio/dptx
else
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/audio/sepolicy/hdmi_audio/drmdp
endif

include device/google/gs-common/audio/common.mk

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/audio/aidl/device_framework_matrix_product.xml

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
$(call soong_config_set,aoc_audio_func,dump_usecase_data,true)
$(call soong_config_set,aoc_audio_func,hal_socket_control,true)
$(call soong_config_set,aoc_audio_func,record_tuning_keys,true)
$(call soong_config_set,aoc_audio_func,aidl_command_interface,true)
endif

$(call soong_config_set,pixel_audio_hal_type,aidl_build,true)
