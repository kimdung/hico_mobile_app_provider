import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widget_hico/button/general_button.dart';

part 'medical_screen_extension.dart';

class MeidcalScreen extends StatelessWidget {
  const MeidcalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
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
                    textEditng: TextEditingController(),
                    title: 'medical.symptom.title'.tr,
                    description: 'medical.symptom.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: TextEditingController(),
                    title: 'medical.test_method.title'.tr,
                    description: 'medical.test_method.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: TextEditingController(),
                    title: 'medical.name_disease.title'.tr,
                    description: 'medical.name_disease.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: TextEditingController(),
                    title: 'medical.treatments.title'.tr,
                    description: 'medical.treatments.description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: TextEditingController(),
                    title: 'medical.book.title'.tr,
                    description: 'medical.book_description'.tr,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  _buildInputTextArea(
                    textEditng: TextEditingController(),
                    title: 'medical.doctor_comments.title'.tr,
                    description: 'medical.doctor_commnets.description'.tr,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GeneralButton(
                      onPressed: () {},
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
      ),
    );
  }
}
