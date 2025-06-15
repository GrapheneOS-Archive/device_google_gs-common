PRODUCT_PACKAGES += \
       android.hardware.bluetooth-V1-ndk.so \
       android.hardware.bluetooth.finder-V1-ndk.so \
       android.hardware.bluetooth.ranging-V1-ndk.so \
       android.hardware.bluetooth.prebuilt.xml \
       android.hardware.bluetooth_le.prebuilt.xml


BOARD_SEPOLICY_DIRS += device/google/gs-common/bcmbt/sepolicy
BOARD_SEPOLICY_DIRS += hardware/google/pixel-sepolicy/powerstats

DEVICE_MANIFEST_FILE += device/google/gs-common/bcmbt/manifest_bluetooth.xml
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/bcmbt/compatibility_matrix.xml
