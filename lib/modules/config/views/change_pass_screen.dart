import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/resource/assets_constant/images_constants.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/decoration/text_field_decoration.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widget_hico/button/general_button.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../../call/pickup/picker_layout.dart';
import '../controllers/config_controller.dart';

class ChangePassScreen extends GetView<ConfigController> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      controller.callMethods,
      scaffold: Scaffold(
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
            'change_password'.tr,
            style: TextAppStyle().titleAppBarStyle(),
          ),
          elevation: 4,
          backgroundColor: Colors.white,
          shadowColor: AppColor.appbarColorLight.withOpacity(0.8),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Image.asset(ImageConstants.forgotPasswordChange)),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'change_pass_title'.tr,
                    textAlign: TextAlign.center,
                    style: TextAppStyle().genaralTextStyle().copyWith(
                        color: AppColor.thirdTextColorLight,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Form(
                  key: controller.changePassForm,
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 14),
                        _buildOldPassword(),
                        const SizedBox(height: 4),
                        _buildPassword(),
                        const SizedBox(height: 4),
                        _buildConfirmPassword(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: GeneralButton(
                    onPressed: () {
                      controller.changePassword();
                    },
                    borderRadius: BorderRadius.circular(24),
                    borderColor: AppColor.primaryColorLight,
                    backgroundColor: AppColor.primaryColorLight,
                    child: Text(
                      'confirm'.tr,
                      style: TextAppStyle().titleButtonStyle(),
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildOldPassword() {
    return TextFormField(
      controller: controller.oldPasswordController,
      keyboardType: TextInputType.text,
      obscureText: controller.hidePassword.value,
      cursorColor: AppColor.fifthTextColorLight,
      style: TextAppStyle().normalTextGrey(),
      decoration: TextFieldDecoration.borderLogin(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.dividerColorLight,
        hintText: ' ${'old_pass'.tr}',
        hintStype: TextAppStyle().genaralTextStyle().copyWith(
              color: AppColor.dividerColorLight,
            ),
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: 12),
          child: FCoreImage(
            IconConstants.icKey,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.hideShowPassword();
          },
          icon: Icon(
            !controller.hidePassword.value ? Icons.visibility : Icons.visibility_off,
            color: AppColor.gray1,
          ),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'enter_old_pass'.tr : null,
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: controller.newsPasswordController,
      keyboardType: TextInputType.text,
      obscureText: controller.hideNewPassword.value,
      cursorColor: AppColor.fifthTextColorLight,
      style: TextAppStyle().normalTextGrey(),
      decoration: TextFieldDecoration.borderLogin(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.dividerColorLight,
        hintText: ' ${'new_pass'.tr}',
        hintStype: TextAppStyle().genaralTextStyle().copyWith(
              color: AppColor.dividerColorLight,
            ),
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: 12),
          child: FCoreImage(
            IconConstants.icKey,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.hideShowNewPassword();
          },
          icon: Icon(
            !controller.hideNewPassword.value ? Icons.visibility : Icons.visibility_off,
            color: AppColor.gray1,
          ),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'enter_new_pass'.tr : null,
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: controller.confirmPasswordController,
      keyboardType: TextInputType.text,
      obscureText: controller.hideRetypePassword.value,
      cursorColor: AppColor.fifthTextColorLight,
      style: TextAppStyle().normalTextGrey(),
      decoration: TextFieldDecoration.borderLogin(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.dividerColorLight,
        hintText: ' ${'confirm_new_pass'.tr}',
        hintStype: TextAppStyle().genaralTextStyle().copyWith(
              color: AppColor.dividerColorLight,
            ),
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: 12),
          child: FCoreImage(
            IconConstants.icKey,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.hideShowRetypePassword();
          },
          icon: Icon(
            !controller.hideRetypePassword.value ? Icons.visibility : Icons.visibility_off,
            color: AppColor.gray1,
          ),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'incorrect_confirm_pass'.tr : null,
    );
  }
}
