ifeq (true,$(PRODUCT_16K_DEVELOPER_OPTION))
PRODUCT_SOONG_NAMESPACES += device/google/gs-common/insmod/16k
else
PRODUCT_SOONG_NAMESPACES += device/google/gs-common/insmod/4k
endif

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/insmod/sepolicy
PRODUCT_PACKAGES += \
        insmod.sh \
        init.common.cfg
