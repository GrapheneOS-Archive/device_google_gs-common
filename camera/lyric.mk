PRODUCT_SOONG_NAMESPACES += \
    hardware/google/camera

$(call soong_config_set,lyric,use_lyric_camera_hal,true)
$(call soong_config_set,google3a_config,gcam_awb,true)
$(call soong_config_set,google3a_config,ghawb_truetone,true)

# Flag controls whether Lyric apex can be located in the dist-directory.
$(call soong_config_set, lyric, dist_lyric_apex, $(RELEASE_PIXEL_DIST_LYRIC_APEX))

# Select GCH backend.
# TODO(b/192681010): This dependency inversion should be removed.
ifneq ($(wildcard vendor/google/services/LyricCameraHAL/src),)
$(call soong_config_set,gch,hwl_library,lyric)
endif

# Use build-time flag to select whether to build from source
# or ingest prebuilt-apex.  We would want the development teams
# using release configuration: (trunk-staging) to build from source.
# All shipping releases will switch to prebuilts (trunk+)
# if this condition is not true, then build from source.

# Fallback if the prebuilts directory does not exist, then we must
# build from source no matter what, so we log a warning
ifeq ($(RELEASE_PIXEL_CAMERA_ENABLE_PREBUILT),true)
  ifeq ($(wildcard vendor/google/services/LyricCameraHAL/prebuilt),)
    $(warning Lyric prebuilt directory is missing, it will be built from source)
    BUILD_LYRIC_FROM_SOURCE := true
  else
    BUILD_LYRIC_FROM_SOURCE := false
  endif
else
  BUILD_LYRIC_FROM_SOURCE := true
endif  # RELEASE_PIXEL_CAMERA_ENABLE_PREBUILT

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += \
    device/google/gs-common/camera/device_framework_matrix_product.xml

DEVICE_MATRIX_FILE += \
    device/google/gs-common/camera/compatibility_matrix.xml

# sepolicy dir is added in dump.mk.
# Make doesn't deduplicate sepolicy dirs, so including it here causes build errors.