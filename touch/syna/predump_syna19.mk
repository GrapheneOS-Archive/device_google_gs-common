PRODUCT_VENDOR_PROPERTIES += ro.vendor.touch.dump.sys=/sys/class/spi_master/spi19/spi19.0/synaptics_tcm.0/sysfs

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/touch/syna/predump_sepolicy

PRODUCT_PACKAGES += predump_syna.sh
