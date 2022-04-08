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
import '../../../shared/widgets/image_widget/image_widget.dart';

class ProfileController extends BaseController {
  late Rx<String> images;
  Rx<UserInfoModel> info = Rx(UserInfoModel());
  final _uiRepository = Get.find<HicoUIRepository>();

  final imageWidget = ImageWidgetController();
  ProfileController() {
    _loadData();
  }

  @override
  Future<void> onInit() {
    return super.onInit();
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
      // ignore: always_put_control_body_on_new_line
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
}
