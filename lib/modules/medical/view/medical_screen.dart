import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widget_hico/button/general_button.dart';
import '../../../shared/widget_hico/widget_touch_hide_keyboard.dart';
import '../controller/medical_controller.dart';

part 'medical_screen_extension.dart';

class MeidcalScreen extends GetView<MedicalController> {
  const MeidcalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: WidgetTouchHideKeyBoard(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 29.0,
              ),
              child: Column(
                children: [
                  _buildInputTextArea(
                    textEditng: controller.symptomController,
                    title: '症状',
                    description: 'medical.symptom.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: controller.testMethodController,
                    title: '検査方法',
                    description: 'medical.test_method.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: controller.diseaseNameController,
                    title: '病名',
                    description: 'medical.name_disease.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: controller.treatmentsController,
                    title: '治療方法',
                    description: 'medical.treatments.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: controller.appointmentNextTimeController,
                    title: '次回予約',
                    description: 'medical.book_description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: controller.commentController,
                    title: '先生コメント',
                    description: 'medical.doctor_commnets.description'.tr,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GeneralButton(
                      onPressed: () {
                        controller.confirmSub();
                      },
                      borderRadius: BorderRadius.circular(24),
                      borderColor: AppColor.primaryColorLight,
                      backgroundColor: AppColor.primaryColorLight,
                      child: Text(
                        'medical.send'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
