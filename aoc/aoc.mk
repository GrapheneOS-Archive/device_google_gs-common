BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/aoc/sepolicy

PRODUCT_PACKAGES += dump_aoc \
		    aocd \
		    aocxd

PRODUCT_COPY_FILES += \
	device/google/gs-common/aoc/conf/init.aoc.daemon.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.aoc.rc

ifneq ($(wildcard vendor/google/whitechapel/aoc/aocx/aidl/aocx/framework_compatibility_matrix.xml),)
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    vendor/google/whitechapel/aoc/aocx/aidl/aocx/framework_compatibility_matrix.xml
endif

# AoC debug support
PRODUCT_PACKAGES_DEBUG += \
	aocdump \
	aocutil \
	aoc_audio_cfg \
	vp_util \
	aocx_tool
