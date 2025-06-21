BOARD_SEPOLICY_DIRS += device/google/gs-common/pixel_ril/sepolicy

# TODO: Verify that this is the correct approach for pixel_ril manifest extraction
#       with corresponding compatibility matrix file declared here.
# ifeq ($(SIM_COUNT), 2)
#     DEVICE_MANIFEST_FILE += device/google/gs-common/pixel_ril/manifest_ril_ds.xml
# else
#     DEVICE_MANIFEST_FILE += device/google/gs-common/pixel_ril/manifest_ril.xml
# endif
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/pixel_ril/compatibility_matrix.xml

USE_GOOGLE_RIL_EXT := true
