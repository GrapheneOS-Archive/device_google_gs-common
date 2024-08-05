BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/performance/sepolicy

PRODUCT_PACKAGES += dump_perf

# Ensure enough free space to create zram backing device
PRODUCT_PRODUCT_PROPERTIES += \
    ro.zram_backing_device_min_free_mb=1536
