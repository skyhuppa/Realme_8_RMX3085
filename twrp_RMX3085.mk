#
# Copyright (C) 2021 The Android Open Source Project
# Copyright (C) 2021 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Release name
PRODUCT_RELEASE_NAME := RMX3085
DEVICE_PATH := device/realme/RMX3085

# Inherit from those products. Most specific first.
# $(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
# $(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Inherit some common Omni stuff.
 $(call inherit-product, vendor/twrp/config/common.mk)

  PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root) \
 	 $(LOCAL_PATH)/prebuilt/dtb:dtb.img
 
# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := RMX3085
PRODUCT_NAME := twrp_RMX3085
PRODUCT_BRAND := realme
PRODUCT_MODEL := rralme 8
PRODUCT_MANUFACTURER := realme

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_SHIPPING_API_LEVEL := 30    

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd



    
