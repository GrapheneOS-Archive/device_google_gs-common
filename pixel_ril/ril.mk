BOARD_SEPOLICY_DIRS += device/google/gs-common/pixel_ril/sepolicy

ifeq ($(SIM_COUNT), 2)
    DEVICE_MANIFEST_FILE += device/google/gs-common/pixel_ril/manifest_ril_ds.xml
else
    DEVICE_MANIFEST_FILE += device/google/gs-common/pixel_ril/manifest_ril.xml
endif
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/pixel_ril/compatibility_matrix.xml

USE_GOOGLE_RIL_EXT := true
