#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Release name
PRODUCT_RELEASE_NAME := bomb

# 引用默认的编译配置文件，core_64_bit必须先于其他引用，否则不生效
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from bomb device
$(call inherit-product, device/xiaomi/bomb/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := bomb
PRODUCT_NAME := twrp_bomb
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := M2004J7BC
PRODUCT_MANUFACTURER := Xiaomi
#PRODUCT_RELEASE_NAME := Redmi 10X Pro
