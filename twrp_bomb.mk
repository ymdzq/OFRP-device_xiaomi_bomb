#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Release name
PRODUCT_RELEASE_NAME := bomb
DEVICE_PATH := device/xiaomi/bomb

# Inherit from bomb device
$(call inherit-product, device/xiaomi/bomb/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := bomb
PRODUCT_NAME := twrp_bomb
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := M2004J7BC
PRODUCT_MANUFACTURER := Xiaomi
#PRODUCT_RELEASE_NAME := Redmi 10X Pro
