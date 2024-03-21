include build/make/target/product/fullmte.mk

PRODUCT_MODULE_BUILD_FROM_SOURCE := true

BOARD_KERNEL_CMDLINE += bootloader.pixel.MTE_FORCE_ON
