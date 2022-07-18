import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/storage.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/dialog/dialog_confirm_widget.dart';
import '../../../shared/widget_hico/dialog/logout_widget.dart';

class AccountController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  Rx<UserInfoModel> info = Rx(UserInfoModel(
      avatarImage: '',
      documentBackSide: '',
      documentFrontSide: '',
      documentsCertificate: []));
  final storage = Get.find<SharedPreferences>();

  AccountController() {
    loadData();
  }
  @override
  Future<void> onInit() async {
    await super.onInit();
  }

  Future<void> loadData() async {
    info.value = AppDataGlobal.userInfo!;
  }

  Future<void> updateInfo() async {
    await Get.toNamed(Routes.PROFILE)?.then((value) => loadData());
  }

  Future<void> onLogout() async {
    await DialogUtil.showPopup(
      dialogSize: DialogSize.Popup,
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      child: const LogoutWidget(),
      onVaLue: (_value) {
        if (_value != null && _value is int) {
          if (_value == 1) {
            AppDataGlobal.client?.removeDevice(AppDataGlobal.firebaseToken);
            _uiRepository.logout().then((response) {
              AppDataGlobal.accessToken = '';
              storage.setBool(StorageConstants.isLogin, false);
              storage.setBool(StorageConstants.isSocial, false);
              storage.setString(StorageConstants.token, '');

              Get.offAllNamed(Routes.ONBOARDING);
            });
          }
        }
      },
    );
  }

  Future<void> deleteUser() async {
    await DialogUtil.showPopup(
      dialogSize: DialogSize.Popup,
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      child: DialogConfirmWidget(
        title: 'account.required_delete'.tr,
        description: 'account.description_delete'.tr,
      ),
      onVaLue: (_value) {
        if (_value != null && _value is bool) {
          if (_value == true) {
            _uiRepository.deleteUser().then((response) {
              AppDataGlobal.accessToken = '';
              storage.setBool(StorageConstants.isLogin, false);
              storage.setBool(StorageConstants.isSocial, false);
              storage.setString(StorageConstants.token, '');
              Get.offAllNamed(Routes.ONBOARDING);
            });
          }
        }
      },
    );
  }

  @override
  void onClose() {}
}
