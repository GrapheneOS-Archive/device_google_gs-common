# Create symlink for bootloader
$(shell rm -f "pixel_current_bootloader")
ifdef BOOTLOADER_FILE_PATH
$(shell ln -sf ${BOOTLOADER_FILE_PATH} "pixel_current_bootloader")
else ifdef BOOTLOADER_RADIO_FILE_PATH
$(shell ln -sf ${BOOTLOADER_RADIO_FILE_PATH} "pixel_current_bootloader")
endif

# Create symlink for kernel
$(shell rm -f "pixel_current_kernel")
ifdef TARGET_KERNEL_DIR
$(shell ln -sf ${TARGET_KERNEL_DIR} "pixel_current_kernel")
endif

# Create symlink for radio
$(shell rm -f "pixel_current_radio")
ifdef RADIO_FILE_PATH
$(shell ln -sf ${RADIO_FILE_PATH} "pixel_current_radio")
else ifdef BOOTLOADER_RADIO_FILE_PATH
$(shell ln -sf ${BOOTLOADER_RADIO_FILE_PATH} "pixel_current_radio")
endif

# Create symlink for radiocfg
$(shell rm -f "pixel_current_radiocfg")
ifdef SRC_MDM_CFG_DIR
$(shell ln -sf ${SRC_MDM_CFG_DIR} "pixel_current_radiocfg")
endif
