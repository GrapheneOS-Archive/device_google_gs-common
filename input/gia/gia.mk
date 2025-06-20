BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/input/gia/sepolicy

# TODO: This probably should be removed, but need to verify it doesn't exist. Difficult to grep for.
PRODUCT_PACKAGES += gia

# DEVICE_MANIFEST_FILE += device/google/gs-common/input/gia/aidl/manifest.xml
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/input/gia/aidl/compatibility_matrix.xml
