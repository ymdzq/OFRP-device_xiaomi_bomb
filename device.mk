#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/bomb

# dynamic partition stuff
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Vibrator
PRODUCT_PACKAGES += \
	android.hardware.vibrator@1.3-service.mtk.recovery
