import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/models/user/user_services_model.dart';
import 'package:ui_api/models/user/workplaces_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../../base/base_controller.dart';
import '../../../../data/app_data_global.dart';
import '../../../../resource/assets_constant/icon_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/utils/dialog_util.dart';
import '../../../../shared/widget_hico/dialog/normal_widget.dart';

class ServiceController extends BaseController {
  final Rx<int> totalRecord = Rx(0);

  List<int> listRecord = List<int>.generate(20, (i) => i + 1);

  Rx<UserInfoModel> info = Rx(UserInfoModel(
      avatarImage: '',
      documentBackSide: '',
      documentsCertificate: [],
      documentFrontSide: ''));
  final _uiRepository = Get.find<HicoUIRepository>();

  ServiceController() {
    _loadData();
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

  Future<void> edit() async {
    await Get.toNamed(Routes.UPDATE_SERVICE)?.then((value) {
      _loadData();
    });
  }

  Future<void> request() async {
    try{
        await EasyLoading.show();
        await _uiRepository.requestUpdateService().then((response) {
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
          });
    }catch(e){
      await EasyLoading.dismiss();
    }
    
  }

  Future<void> changeServiceArrow(UserServicesCategoryModel item) async {
    try{
      item.openChild = !item.openChild!;
      var index = info.value.services?.indexWhere((element) => element.serviceCategoryId == item.serviceCategoryId);
      if (index != -1) {
        info.value.services?[index!] = item;
        info.refresh();
      }
    }catch(e){
      await EasyLoading.dismiss();
    }
    
  }

  Future<void> changeArrow(WorkplacesModel item) async {
    try{
      item.openChild = !item.openChild!;
      var index = info.value.workplaces?.indexWhere((element) => element.provinceId == item.provinceId);
      if (index != -1) {
        info.value.workplaces?[index!] = item;
        info.refresh();
      }
    }catch(e){
      await EasyLoading.dismiss();
    }
    
  }

  @override
  void onClose() {}
}
