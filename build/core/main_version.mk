BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
ifneq ($(filter OFFICIAL,$(NEZUKO_BUILD_TYPE)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(TARGET_DEVICE)/$(TARGET_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT) 

# NezukoOS System Version
ADDITIONAL_BUILD_PROPERTIES += \
  ro.nezuko.version=$(NEZUKO_DISPLAY_VERSION) \
  ro.nezuko.build.status=$(NEZUKO_BUILD_TYPE) \
  ro.modversion=$(NEZUKO_MOD_VERSION) \
  ro.nezuko.build.date=$(BUILD_DATE) \
  ro.nezuko.buildtype=$(NEZUKO_BUILD_TYPE) \
  ro.nezuko.fingerprint=$(NEZUKO_FINGERPRINT) \
  ro.nezuko.device=$(NEZUKO_BUILD) \
  org.nezuko.version=$(NEZUKOVERSION)
  ro.nezuko.build.version=$(NEZUKOVERSION)