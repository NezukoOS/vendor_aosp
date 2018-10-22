# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2017-2018 AOSiP
# Copyright (C) 2019 AOSDP
# Copyright (C) 2020-2021 Fluid
# Copyright (C) 2021 NezukoOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# Nezuko OTA update package

NEZUKO_TARGET_PACKAGE := $(PRODUCT_OUT)/$(NEZUKO_VERSION).zip
MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

ifneq ($(IS_CIENV),true)
  CL_RED="\033[31m"
  CL_GRN="\033[32m"
  CL_YLW="\033[33m"
  CL_BLU="\033[34m"
  CL_MAG="\033[35m"
  CL_CYN="\033[36m"
  CL_RST="\033[0m"
endif

.PHONY: nezuko otapackage bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
nezuko: otapackage
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(NEZUKO_TARGET_PACKAGE)
	$(hide) $(MD5) $(NEZUKO_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(NEZUKO_TARGET_PACKAGE).md5sum
	$(hide) ./vendor/nezuko/tools/generate_json_build_info.sh $(NEZUKO_TARGET_PACKAGE)
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}Nezuko ! ${txtrst}";
	@echo -e ""
	@echo -e ${CL_GRN}"=========================Package Complete========================="${CL_GRN}
	@echo -e ${CL_CYN}"                                                                  "${CL_CYN}
	@echo -e ${CL_YLW}"            Build Completed Successfully       "${CL_YLW}
	@echo -e ${CL_CYN}"                                                                  "${CL_CYN}
	@echo -e ${CL_RED}"******************************************************************"                                                           
	@echo -e ${CL_YLW}"Zip: "${CL_YLW} $(NEZUKO_TARGET_PACKAGE)${CL_YLW}
	@echo -e ${CL_YLW}"MD5: "${CL_YLW}" `cat $(NEZUKO_TARGET_PACKAGE).md5sum | awk '{print $$1}' `"${CL_YLW}
	@echo -e ${CL_YLW}"Size:"${CL_YLW}" `du -sh $(NEZUKO_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_YLW}
	@echo -e ${CL_YLW}"id:"${CL_YLW}"`sha256sum $(NEZUKO_TARGET_PACKAGE) | cut -d ' ' -f 1`"${CL_YLW}
	@echo -e ${CL_GRN}"==================================================================="${CL_GRN}

bacon: nezuko