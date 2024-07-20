PRODUCT_SOONG_NAMESPACES += hardware/google/video/cnm

PRODUCT_PACKAGES += \
	google.hardware.media.c2@3.0-service \
	libgc2_store \
	libgc2_base \
	libgc2_vdi_vpu \
	libgc2_log \
	libgc2_utils \
	libgc2_av1_dec \
	libgc2_vp9_dec \
	libgc2_hevc_dec \
	libgc2_avc_dec \
	libgc2_av1_enc \
	libgc2_hevc_enc \
	libgc2_avc_enc \
	vpu_firmware

$(call soong_config_set,cnm,soc,$(TARGET_BOARD_PLATFORM))

BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/mediacodec/vpu/sepolicy
