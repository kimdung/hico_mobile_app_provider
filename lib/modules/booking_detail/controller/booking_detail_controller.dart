import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/invoice/invoice_extend_model.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/invoice/booking_extend_request.dart';
import 'package:ui_api/response/invoice/booking_extend_response.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';

class BookingDetailController extends BaseController {
  
  final _uiRepository = Get.find<HicoUIRepository>();
  BookingExtendRequest request = BookingExtendRequest();
  Rx<InvoiceExtendModel> extendInfo = Rx(InvoiceExtendModel());

  BookingDetailController(){
    request = Get.arguments;
  }

 @override
  Future<void> onInit() async {
    await super.onInit();  
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      await EasyLoading.show();
      await _uiRepository.subDetail(request.invoiceId??0, request.subId??0).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          extendInfo.value = response.data!;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
      await DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        child: NormalWidget(
          icon: IconConstants.icFail,
          title: 'error_mess'.tr,
        ),
        onVaLue: (value) {
          Get.back();
        },
      );
      return;
    }
  }

    Future<void> onSubmit(int status) async {
    try {
      await EasyLoading.show();
      request.status = status;
      await _uiRepository.subConfirm(request).then((response) {
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
            if(response.status == CommonConstants.statusOk){
              Get.back();
            }
          },
        );
      });  
    } catch (e) {
      await EasyLoading.dismiss();
       await DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        child: NormalWidget(
          icon: IconConstants.icFail,
          title: 'error_mess'.tr,
        ),
        onVaLue: (value) {
          Get.back();
        },
      );
      return;
    }
  }

}
