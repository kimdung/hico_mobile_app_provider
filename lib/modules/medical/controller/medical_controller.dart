import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/invoice/confirm_sub_request.dart';

import '../../../base/base_controller.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';

class MedicalController extends BaseController {
  TextEditingController symptomController = TextEditingController();
  TextEditingController testMethodController = TextEditingController();
  TextEditingController diseaseNameController = TextEditingController();
  TextEditingController treatmentsController = TextEditingController();
  TextEditingController appointmentNextTimeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  Rx<ConfirmSubRequest> request = Rx(ConfirmSubRequest());
  final _repository = Get.find<HicoUIRepository>();
  int id = 0;

  @override
  Future<void> onInit() async {
    id = Get.arguments;
    log('Invoice Id: ${id.toString()}');
    return super.onInit();
  }

  Future<void> confirmSub() async {
    request.value.invoiceId = id;
    request.value.symptom = symptomController.text;
    request.value.testMethod = testMethodController.text;
    request.value.diseaseName = diseaseNameController.text;
    request.value.treatments = treatmentsController.text;
    request.value.appointmentNextTime = appointmentNextTimeController.text;
    request.value.comment = commentController.text;
    await _repository.confirmSub(request.value).then((response) {
      if (response.status == CommonConstants.statusOk) {
        log(response.toString());
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
        ).then((value) {
          Get.back();
        });
        return;
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
