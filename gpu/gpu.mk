BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/gpu/sepolicy

PRODUCT_PACKAGES += gpu_probe

USE_MAPPER5 := true

PRODUCT_PACKAGES += pixel_gralloc_allocator
PRODUCT_PACKAGES += pixel_gralloc_mapper

ifeq ($(USE_MAPPER5), true)
$(call soong_config_set,pixel_gralloc,mapper_version,mapper5)
$(call soong_config_set,aion_buffer,mapper_version,mapper5)
else
$(call soong_config_set,pixel_gralloc,mapper_version,mapper4)
$(call soong_config_set,aion_buffer,mapper_version,mapper4)
endif
