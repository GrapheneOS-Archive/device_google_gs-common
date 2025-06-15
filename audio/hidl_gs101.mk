DEVICE_MANIFEST_FILE += device/google/gs-common/audio/hidl/manifest_gs101$(LOCAL_64ONLY).xml

# Audio HAL Server & Default Implementations
PRODUCT_PACKAGES += \
	android.hardware.audio.service \
	android.hardware.audio@7.1-impl \
	android.hardware.audio.effect@7.0-impl \
	android.hardware.bluetooth.audio-impl \
	android.hardware.soundtrigger@2.3-impl

#Audio HAL libraries
PRODUCT_PACKAGES += \
	audio.usb.default \
	audio.usbv2.default \
	audio.bluetooth.default \
	audio.r_submix.default

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/audio/sepolicy/hidl

include device/google/gs-common/audio/common.mk

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/audio/hidl/device_framework_matrix_product_gs101.xml