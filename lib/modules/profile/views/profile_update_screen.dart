import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../../resource/assets_constant/images_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/decoration/text_field_decoration.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widget_hico/box_decoration/box_decoration.dart';
import '../../../shared/widget_hico/button/general_button.dart';
import '../../../shared/widget_hico/image_widget/network_image.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../controllers/profile_update_controller.dart';

part 'profile_update_extension.dart';

class ProfileUpdateScreen extends GetView<ProfileUpDateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            IconConstants.icBack,
            width: 11,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'profile.title'.tr,
          style: TextAppStyle().titleAppBarStyle(),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Obx(() => Container(
                child: Column(
                  children: [
                    Container(
                      color: AppColor.greyBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: FCoreImage(IconConstants.icProfileEdit)),
                          Expanded(
                            child: Text(
                              'profile.cap'.tr,
                              style: TextAppStyle().secondTextStyle().copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            controller.pickAvatar(context);
                          },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(120)),
                            child: controller.info.value.avatarImage.isEmpty
                                    ? FCoreImage(
                                        ImageConstants.avatar,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      )
                                    : NetWorkImage(
                                        image:
                                            controller.info.value.avatarImage,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        controller.pickAvatar(context);
                      },
                      child: Text(
                        'profile.add_avatar'.tr,
                        style: TextAppStyle().genaralTextStyle().copyWith(
                              color: AppColor.primaryTextColorLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: controller.updateForm,
                        child: Column(
                          children: [
                            //name
                            _buildLabel(title: 'support.name'.tr, required: 1),
                            const SizedBox(height: 8),
                            _buildInputFullname(),
                            //gender
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                    child: _buildLabel(
                                        title: 'profile.gender'.tr,
                                        required: 1)),
                                Expanded(
                                  child: _buildInputRadio(),
                                )
                              ],
                            ),
                            //birthday
                            const SizedBox(height: 14),
                            _buildLabel(
                                title: 'profile.birthday'.tr, required: 1),
                            const SizedBox(height: 8),
                            _buildInputBirthDay(context),
                            //email
                            const SizedBox(height: 14),
                            _buildLabel(title: 'profile.email'.tr, required: 1),
                            const SizedBox(height: 8),
                            _buildInputEmail(),
                            //phone
                            const SizedBox(height: 14),
                            _buildLabel(title: 'support.phone'.tr, required: 1),
                            const SizedBox(height: 8),
                            _buildInputPhone(),

                            //bank
                            const SizedBox(height: 14),
                            _buildLabel(
                                title: 'profile.update.bank'.tr, required: 1),
                            const SizedBox(height: 8),
                            buildSelectComponent(
                              title: controller.bankName.value != ''
                                  ? controller.bankName.value
                                  : 'profile.update.bank_name'.tr,
                              textColor: TextAppStyle().smallTextGrey(),
                              prefixIcon: true,
                              prefixImage:
                                  'lib/resource/assets_resources/icons/keyboard_arrow_down_grey.png',
                              onPress: () => controller.getBank(context),
                            ),
                            //_buildInputBankName(),
                            const SizedBox(height: 16),
                            _buildInputBranchName(),
                            const SizedBox(height: 16),
                            _buildInputBankAccount(),
                            const SizedBox(height: 16),
                            _buildInputBankNumber(),
                            const SizedBox(height: 16),

                            Container(
                              child: Column(
                                children: [
                                  _buildLabel(
                                      title: 'profile.update.address'.tr,
                                      required: 1),
                                  //address
                                  const SizedBox(height: 14),
                                  _buildInputAddressCode(),
                                  if (controller.showSuggest.value != 0)
                                    buildSuggestAddress(),
                                  const SizedBox(height: 16),
                                  _buildInputTemplate(
                                      textEditng: controller.province,
                                      focusNode: AlwaysDisabledFocusNode(),
                                      title: 'profile.update.provice'.tr),
                                  const SizedBox(height: 16),
                                  _buildInputTemplate(
                                      textEditng: controller.district,
                                      focusNode: AlwaysDisabledFocusNode(),
                                      title: 'profile.update.district'.tr),
                                  const SizedBox(height: 16),
                                  _buildInputTextArea(
                                      textEditng: controller.address,
                                      title: 'profile.update.address_block'.tr),
                                ],
                              ),
                            ),

                            //stasion
                            const SizedBox(height: 14),
                            _buildLabel(
                                title: 'profile.update.station'.tr,
                                required: 1),
                            const SizedBox(height: 8),
                            _buildInputTemplate(
                                textEditng: controller.station,
                                title: 'profile.update.station_holder'.tr),

                            //image
                            const SizedBox(height: 14),
                            _buildLabel(
                                title: 'profile.update.image_card'.tr,
                                required: 1),
                            const SizedBox(height: 12),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildImageItem(
                                      image: ImageConstants.imageCardBefore,
                                      title: 'profile.image_before'.tr,
                                      current_image: controller
                                          .info.value.documentFrontSide,
                                      file: controller.documentFrontSide.value,
                                      onPress: () {
                                        controller
                                            .pickDocumentFrontSide(context);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildImageItem(
                                      image: ImageConstants.imageCardAfter,
                                      title: 'profile.image_after'.tr,
                                      current_image: controller
                                          .info.value.documentBackSide,
                                      file: controller.documentBackSide.value,
                                      onPress: () {
                                        controller
                                            .pickDocumentBackSide(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //number years in japan
                            const SizedBox(height: 14),
                            _buildLabel(
                                title:
                                    'profile.update.number_years_in_japan'.tr,
                                required: 1),
                            const SizedBox(height: 8),
                            buildSelectComponent(
                                    title: controller.numberYearJapanDataList[ controller.isNumberYearsInJapan.value].content,
                                    textColor: TextAppStyle().smallTextGrey(),
                                    prefixIcon: true,
                                    prefixImage:
                                        'lib/resource/assets_resources/icons/keyboard_arrow_down_grey.png',
                                    onPress: () => controller
                                        .getNumberYearsInJapan(context),
                                  ),
                            //education
                            const SizedBox(height: 14),
                            _buildLabel(
                                title: 'profile.education'.tr, required: 1),
                            const SizedBox(height: 8),
                            _buildInputTemplate(
                                textEditng: controller.education,
                                title: 'profile.update.education'.tr),
                            //degree
                            const SizedBox(height: 14),
                            buildHeader(title: 'profile.degree'.tr),
                            const SizedBox(height: 8.0),
                            Container(
                              child: (controller.info.value.documentsCertificate.isNotEmpty)
                                  ? GridView.count(
                                      crossAxisCount: 4,
                                      shrinkWrap: true,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 8,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        ...List.generate(
                                          controller.info.value.documentsCertificate.length,
                                          (int index) => Stack(
                                            children: [
                                              controller.info.value.documentsCertificate[index].extension
                                                          .toString()
                                                          .contains('jpg') ||
                                                      controller.info.value.documentsCertificate[index].extension
                                                          .toString()
                                                          .contains('png')
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: NetWorkImage(
                                                        image: controller.info.value.documentsCertificate[index].url!,
                                                        fit: BoxFit.cover,
                                                        height: 78,
                                                    ),)
                                                  : GFBorder(
                                                      dashedLine: const [4, 6],
                                                      radius:
                                                          const Radius.circular(
                                                              6),
                                                      strokeWidth: 1,
                                                      type: GFBorderType.rect,
                                                      color: AppColor
                                                          .primaryColorLight,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.upload_file,
                                                          color: AppColor
                                                              .primaryColorLight,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                    ),
                                              Positioned(
                                                  right: 3,
                                                  top: 3,
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.onRemoveCetificateFile(index);
                                                    },
                                                    child: Container(
                                                      width: 14,
                                                      height: 14,
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .secondBackgroundColorLight
                                                            .withOpacity(0.8),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: FCoreImage(
                                                          IconConstants
                                                              .icClose),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.pickCetificateImage(context);
                                          },
                                          child: GFBorder(
                                            dashedLine: const [4, 6],
                                            radius: const Radius.circular(6),
                                            strokeWidth: 1,
                                            type: GFBorderType.rect,
                                            color: AppColor.primaryColorLight,
                                            child: FCoreImage(
                                              'lib/resource/assets_resources/icons/camera.png',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.pickCetificateFile();
                                          },
                                          child: GFBorder(
                                            dashedLine: const [4, 6],
                                            radius: const Radius.circular(6),
                                            strokeWidth: 1,
                                            type: GFBorderType.rect,
                                            color: AppColor.primaryColorLight,
                                            child: FCoreImage(
                                              'lib/resource/assets_resources/icons/pin.png',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                controller.pickCetificateImage(context);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7),
                                                decoration: BoxDecoration(
                                                  color: AppColor
                                                      .secondBackgroundColorLight,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Column(
                                                  children: [
                                                    FCoreImage(
                                                      'lib/resource/assets_resources/icons/camera.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'profile.update.image'.tr,
                                                      style: TextAppStyle()
                                                          .smallTextPink(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                controller.pickCetificateFile();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7),
                                                decoration: BoxDecoration(
                                                  color: AppColor
                                                      .secondBackgroundColorLight,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Column(
                                                  children: [
                                                    FCoreImage(
                                                      'lib/resource/assets_resources/icons/pin.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'File PDF',
                                                      style: TextAppStyle()
                                                          .smallTextPink(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 8),
                            //level
                            _buildInputTextArea(
                                textEditng: controller.level,
                                title: 'profile.update.level'.tr),
                            const SizedBox(height: 14),
                            //curriculum vitae
                            _buildLabel(
                                title: 'profile.update.curriculum_vitae'.tr,
                                required: 0),
                            const SizedBox(height: 8.0),
                            _buildPickFile(files: controller.info.value.curriculumVitaeFiles, type: CommonConstants.curriculumVitaeFiles),
                            const SizedBox(height: 14),
                            //experience
                            _buildLabel(
                                title: 'profile.update.experience_title'.tr,
                                required: 0),
                            const SizedBox(height: 8),
                            _buildPickFile(files: controller.info.value.workExperienceFiles, type: CommonConstants.workExperienceFiles),
                            // const SizedBox(height: 8),
                            // _buildInputTextArea(
                            //     textEditng: controller.experience,
                            //     title: 'profile.update.experience'.tr),
                            const SizedBox(height: 14.0),
                            // interpreting experience
                            _buildLabel(
                                title:
                                    'profile.update.interpreting_experience'.tr,
                                required: 1),
                            buildSelectComponent(
                                    title: controller.interpretationExperienceDataList[ controller.isInterpretationExperience.value].content,
                                    textColor: TextAppStyle().smallTextGrey(),
                                    prefixIcon: true,
                                    prefixImage:
                                        'lib/resource/assets_resources/icons/keyboard_arrow_down_grey.png',
                                    onPress: () => controller
                                        .getInterpretationExperience(context),
                                  ),
                            const SizedBox(height: 8),
                            _buildInputTextArea(
                              textEditng:
                                  controller.interpretingExperienceDetail,
                              title:
                                  'profile.update.translatation_experience.hint'
                                      .tr,
                            ),
                            const SizedBox(height: 20),
                            //translation experience
                            _buildLabel(
                                title:
                                    'profile.update.translation_experience'.tr,
                                required: 1),
                            buildSelectComponent(
                                    title: controller.translationExperienceDataList[ controller.isTranslatationExperience.value].content,
                                    textColor: TextAppStyle().smallTextGrey(),
                                    prefixIcon: true,
                                    prefixImage:
                                        'lib/resource/assets_resources/icons/keyboard_arrow_down_grey.png',
                                    onPress: () => controller
                                        .getTranslationExperience(context),
                                  ),
                            const SizedBox(height: 8),
                            _buildInputTextArea(
                                textEditng:
                                    controller.translationExperienceDetail,
                                title:
                                    'profile.update.translatation_experience.hint'
                                        .tr),
                            //button
                            const SizedBox(height: 30),
                            GeneralButton(
                                onPressed: () {
                                  controller.updated();
                                },
                                borderRadius: BorderRadius.circular(24),
                                borderColor: AppColor.primaryColorLight,
                                backgroundColor: AppColor.primaryColorLight,
                                child: Text(
                                  'continue'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ))),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
