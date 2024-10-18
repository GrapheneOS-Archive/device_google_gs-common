# Dauntless
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/dauntless/sepolicy
ifneq ($(wildcard vendor/google_nos),)
PRODUCT_SOONG_NAMESPACES += vendor/google_nos/init/dauntless

PRODUCT_PACKAGES += \
    citadeld \
    citadel_updater \
    android.hardware.weaver-service.citadel \
    android.hardware.authsecret-service.citadel \
    android.hardware.oemlock-service.citadel \
    init_citadel \
    android.hardware.strongbox_keystore.xml \
    android.hardware.security.keymint-service.citadel \
    dump_gsc.sh

# USERDEBUG ONLY: Install test packages
PRODUCT_PACKAGES_DEBUG += citadel_integration_tests \
                          pwntest \
                          nugget_targeted_tests \
                          CitadelProvision \
                          nugget_aidl_test_weaver

# Assign default value for RELEASE_GOOGLE_DAUNTLESS_DIR if no trunk flags support
RELEASE_GOOGLE_DAUNTLESS_DIR ?= vendor/google_nos/prebuilts/dauntless

# The production Dauntless firmware will be of flavors evt and d3m2.
# There are also several flavors of pre-release chips. Each flavor
# (production and pre-release) requires the firmware to be signed differently.
DAUNTLESS_FIRMWARE_SIZE := 1048576

# The nearly-production Dauntless chips are "proto1.1"
ifneq (,$(wildcard $(RELEASE_GOOGLE_DAUNTLESS_DIR)/proto11.ec.bin))
ifneq ($(DAUNTLESS_FIRMWARE_SIZE), $(shell stat -c "%s" $(RELEASE_GOOGLE_DAUNTLESS_DIR)/proto11.ec.bin))
$(error GSC firmware size check fail)
endif
PRODUCT_COPY_FILES += \
    $(RELEASE_GOOGLE_DAUNTLESS_DIR)/proto11.ec.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/dauntless/proto11.ec.bin
$(call dist-for-goals,droid,$(RELEASE_GOOGLE_DAUNTLESS_DIR)/proto11.ec.bin)
else
$(error GSC firmware not found in $(RELEASE_GOOGLE_DAUNTLESS_DIR))
endif

# The production Dauntless chips are "evt"
ifneq (,$(wildcard $(RELEASE_GOOGLE_DAUNTLESS_DIR)/evt.ec.bin))
ifneq ($(DAUNTLESS_FIRMWARE_SIZE), $(shell stat -c "%s" $(RELEASE_GOOGLE_DAUNTLESS_DIR)/evt.ec.bin))
$(error GSC firmware size check fail)
endif
PRODUCT_COPY_FILES += \
    $(RELEASE_GOOGLE_DAUNTLESS_DIR)/evt.ec.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/dauntless/evt.ec.bin
$(call dist-for-goals,droid,$(RELEASE_GOOGLE_DAUNTLESS_DIR)/evt.ec.bin)
else
$(error GSC firmware not found in $(RELEASE_GOOGLE_DAUNTLESS_DIR))
endif

# New 2023 production Dauntless chips are "d3m2"
ifneq (,$(wildcard $(RELEASE_GOOGLE_DAUNTLESS_DIR)/d3m2.ec.bin))
ifneq ($(DAUNTLESS_FIRMWARE_SIZE), $(shell stat -c "%s" $(RELEASE_GOOGLE_DAUNTLESS_DIR)/d3m2.ec.bin))
$(error GSC firmware size check fail)
endif
PRODUCT_COPY_FILES += \
    $(RELEASE_GOOGLE_DAUNTLESS_DIR)/d3m2.ec.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/dauntless/d3m2.ec.bin
$(call dist-for-goals,droid,$(RELEASE_GOOGLE_DAUNTLESS_DIR)/d3m2.ec.bin)
else
$(error GSC firmware not found in $(RELEASE_GOOGLE_DAUNTLESS_DIR))
endif

# Intermediate image artifacts are published, but aren't included in /vendor/firmware/dauntless
# in PRODUCT_COPY_FILES
# This is because intermediate images aren't needed on user devices, but the published artifact
# is useful for flashstation purposes.

# proto11 chips need an intermediate image prior to upgrading to newever versions of the firmware
ifneq (,$(wildcard vendor/google_nos/prebuilts/dauntless/intermediate_images/proto11_intermediate.ec.bin))
ifneq ($(DAUNTLESS_FIRMWARE_SIZE), $(shell stat -c "%s" vendor/google_nos/prebuilts/dauntless/intermediate_images/proto11_intermediate.ec.bin))
$(error GSC firmware size check fail)
endif
$(call dist-for-goals,droid,vendor/google_nos/prebuilts/dauntless/intermediate_images/proto11_intermediate.ec.bin)
endif
# evt chips need an intermediate image prior to upgrading to newever versions of the firmware
ifneq (,$(wildcard vendor/google_nos/prebuilts/dauntless/intermediate_images/evt_intermediate.ec.bin))
ifneq ($(DAUNTLESS_FIRMWARE_SIZE), $(shell stat -c "%s" vendor/google_nos/prebuilts/dauntless/intermediate_images/evt_intermediate.ec.bin))
$(error GSC firmware size check fail)
endif
$(call dist-for-goals,droid,vendor/google_nos/prebuilts/dauntless/intermediate_images/evt_intermediate.ec.bin)
endif
# d3m2 chips need an intermediate image prior to upgrading to newever versions of the firmware
ifneq (,$(wildcard vendor/google_nos/prebuilts/dauntless/intermediate_images/d3m2_intermediate.ec.bin))
ifneq ($(DAUNTLESS_FIRMWARE_SIZE), $(shell stat -c "%s" vendor/google_nos/prebuilts/dauntless/intermediate_images/d3m2_intermediate.ec.bin))
$(error GSC firmware size check fail)
endif
$(call dist-for-goals,droid,vendor/google_nos/prebuilts/dauntless/intermediate_images/d3m2_intermediate.ec.bin)
endif

endif # $(wildcard vendor/google_nos)
