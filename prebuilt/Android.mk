LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
    LOCAL_MODULE := realme_prebuilt
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
    LOCAL_HOST_REQUIRED_MODULES := depmod
    LOCAL_POST_INSTALL_CMD += \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/modules; \
        cp -rf $(LOCAL_PATH)/$(PRODUCT_RELEASE_NAME)/modules $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/; \
        mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware; \
        cp -rf $(LOCAL_PATH)/$(PRODUCT_RELEASE_NAME)/firmware $(TARGET_RECOVERY_ROOT_OUT)/vendor/; \
        echo "calling depmod on realme_prebuilt"; \
include $(BUILD_PHONY_PACKAGE)
