SOONG_CONFIG_shared_modem_platform += \
       vendor
SOONG_CONFIG_shared_modem_platform_vendor := $(SHARED_MODEM_PLATFORM_VENDOR)

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/modem/modem_svc_sit/compatibility_matrix.xml
BOARD_SEPOLICY_DIRS += device/google/gs-common/modem/modem_svc_sit/sepolicy
