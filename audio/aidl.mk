
DEVICE_MANIFEST_FILE += device/google/gs-common/audio/aidl/manifest.xml

# Audio HALs
PRODUCT_PACKAGES += \
    android.hardware.audio.service-aidl.aoc \
    vendor.google.whitechapel.audio.hal.parserservice \

PRODUCT_PACKAGES += \
    libvisualizeraidl \
    libbundleaidl \
    libreverbaidl \
    libdynamicsprocessingaidl \
    libloudnessenhanceraidl \
    libdownmixaidl \
    libhapticgeneratoraidl \

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/audio/sepolicy/aidl
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/audio/sepolicy/hdmi_audio

include device/google/gs-common/audio/common.mk

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/audio/aidl/device_framework_matrix_product.xml

PRODUCT_PROPERTY_OVERRIDES += \
       vendor.audio_hal.aidl.enable=true
PRODUCT_SYSTEM_EXT_PROPERTIES += \
       ro.audio.ihaladaptervendorextension_enabled=true

$(call soong_config_set,pixel_audio_hal_type,aidl_build,true)
