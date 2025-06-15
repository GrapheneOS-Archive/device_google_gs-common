PRODUCT_SOONG_NAMESPACES += hardware/google/video/cnm

$(call soong_config_set,cnm,soc,$(TARGET_BOARD_PLATFORM))

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/mediacodec/vpu/sepolicy
