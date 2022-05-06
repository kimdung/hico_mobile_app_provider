import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';
import '../../../shared/widget_hico/dialog/notification_widget.dart';
import '../../../shared/widgets/image_widget/image_widget.dart';

class ProfileController extends BaseController {
  late Rx<String> images;
  Rx<UserInfoModel> info = Rx(UserInfoModel(
      avatarImage: '',
      documentBackSide: '',
      documentFrontSide: '',
      documentsCertificate: []));
  final _uiRepository = Get.find<HicoUIRepository>();
  TextEditingController interpretingExperienceController =
      TextEditingController();
  TextEditingController translationExperienceController =
      TextEditingController();

  final imageWidget = ImageWidgetController();

  ProfileController() {
    _loadData();
  }

  @override
  Future<void> onInit() async {
    await super.onInit();
  }

  Future _loadData() async {
    try {
      await EasyLoading.show();
      await _uiRepository.getInfo().then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.info != null) {
          info.value = response.data!.info!;
          AppDataGlobal.userInfo = response.data!.info!;
          interpretingExperienceController.text =
              AppDataGlobal.userInfo!.interpretationExperienceDetail.toString();
          translationExperienceController.text =
              AppDataGlobal.userInfo!.translationExperienDetail.toString();
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future pickAvatar(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      //call api
      await updateAvatar(imageTemporary);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future updateAvatar(File image) async {
    try {
      await EasyLoading.show();
      await _uiRepository.updateAvatar(image).then((response) {
        EasyLoading.dismiss();
        DialogUtil.showPopup(
          dialogSize: DialogSize.Popup,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          child: NormalWidget(
            icon: response.status == CommonConstants.statusOk
                ? IconConstants.icSuccess
                : IconConstants.icFail,
            title: response.message,
          ),
          onVaLue: (value) {
            if (response.status == CommonConstants.statusOk) {
              info.value = response.data!.info!;
              AppDataGlobal.userInfo = info.value;
            }
          },
        );
        return;
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> next() async {
    await Get.toNamed(Routes.SERVICE);
  }

  void requestUpdateUserInfor() {
    if (info.value.kycStatus == 0) {
      Get.toNamed(Routes.PROFILE_UPDATE);
    } else if (info.value.kycStatus == 2) {
      DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        title: 'Tài khoản đã được xác thực.',
        onVaLue: (value) {},
        child: const NotificationWidget(
          content: 'Thông tin của bạn đang chờ được xử lý.',
        ),
      );
    } else if (info.value.kycStatus == 1) {
      try {
        EasyLoading.show();
        _uiRepository.requestUpdate().then((response) {
          EasyLoading.dismiss();
          DialogUtil.showPopup(
            dialogSize: DialogSize.Popup,
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            child: NormalWidget(
              icon: response.status == CommonConstants.statusOk
                  ? IconConstants.icSuccess
                  : IconConstants.icFail,
              title: response.message,
            ),
            onVaLue: (value) {},
          );
          return;
        });
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
  }

  String convertStr(int code, int type) {
    switch (code) {
      case 2:
        return 'profile.update.number_years_in_japan.one_to_three_year'.tr;
      case 3:
        return 'profile.update.number_years_in_japan.four_to_six_year'.tr;
      case 4:
        return 'profile.update.number_years_in_japan.seven_to_ten_year'.tr;
      case 5:
        return 'profile.update.number_years_in_japan.more_than_ten_year'.tr;
      default:
        return type == 0
            ? 'profile.update.number_years_in_japan.none'.tr
            : 'profile.update.experience.none'.tr;
    }
  }
}
