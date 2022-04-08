part of 'profile_update_screen.dart';

extension ProfileUpdateExtension on ProfileUpdateScreen {
  Widget _buildLabel({required String title, int? required = 0}) {
    return Row(
      children: [
        Text(
          title,
          style: TextAppStyle().genaralTextStyle().copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
        ),
        required == 1
            ? Text(
                ' *',
                style: TextAppStyle().genaralTextStyle().copyWith(
                      color: AppColor.primaryColorLight,
                      fontSize: 16,
                    ),
              )
            : Container(),
      ],
    );
  }

  Widget _buildInputFullname() {
    return TextFormField(
      controller: controller.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        hintText: 'support.hint_name'.tr,
        hintStype: TextAppStyle().secondTextStyle().copyWith(
              color: AppColor.dividerColorLight,
            ),
        radius: 6,
      ),
      style: TextStyle(
          color: AppColor.dividerColorLight,
          fontSize: 12.0,
          fontWeight: FontWeight.w400),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'support.hint_name'.tr : null,
    );
  }

  Widget _buildInputBirthDay(BuildContext context) {
    return BoxDecorationWidget(
      height: 42,
      border: Border.all(color: AppColor.borderGrayColorLight),
      radius: 6,
      child: InkWell(
        onTap: () {
          controller.showDate(context);
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  controller.birthDay.value != ''
                      ? controller.birthDay.value
                      : 'MM/DD/YYYY',
                  style: TextAppStyle().smallTextGrey(),
                ),
              ),
            ),
            FCoreImage(
              IconConstants.icCalendar,
              width: 24,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInputEmail() {
    return TextFormField(
      controller: controller.email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        hintText: 'support.hint_email'.tr,
        hintStype: TextAppStyle().secondTextStyle().copyWith(
              color: AppColor.dividerColorLight,
            ),
        radius: 6,
      ),
      style: TextStyle(
          color: AppColor.dividerColorLight,
          fontSize: 12.0,
          fontWeight: FontWeight.w400),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'support.hint_email'.tr : null,
    );
  }

  Widget _buildInputPhone() {
    return TextFormField(
      controller: controller.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        hintText: 'support.hint_phone'.tr,
        hintStype: TextAppStyle().secondTextStyle().copyWith(
              color: AppColor.dividerColorLight,
            ),
        radius: 6,
      ),
      style: TextStyle(
          color: AppColor.dividerColorLight,
          fontSize: 12.0,
          fontWeight: FontWeight.w400),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'support.hint_phone'.tr : null,
    );
  }

  Widget buildSelectComponent({
    required String title,
    bool prefixIcon = false,
    String? prefixImage,
    double? paddingRight,
    bool shadow = false,
    bool border = true,
    TextStyle? textColor,
    double? padding,
    double? height,
    Function()? onPress,
  }) {
    return BoxDecorationWidget(
      height: 47,
      border: Border.all(color: AppColor.sixTextColorLight),
      radius: 6,
      child: InkWell(
        onTap: onPress,
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(left: padding ?? 6),
                child: Text(
                  title,
                  style: textColor ?? TextAppStyle().smallTextGrey(),
                ),
              ),
            ),
            if (prefixIcon)
              FCoreImage(
                prefixImage ?? IconConstants.icArrowDown,
                width: 24,
              ),
            SizedBox(width: paddingRight ?? 10),
          ],
        ),
      ),
    );
  }

  // Widget _buildInputBankName() {
  //   return TextFormField(
  //     //controller: controller.bankName,
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     keyboardType: TextInputType.text,
  //     cursorColor: AppColor.fifthTextColorLight,
  //     decoration: TextFieldDecoration.borderOutline(
  //       backgroundColor: AppColor.primaryBackgroundColorLight,
  //       borderColor: AppColor.sixTextColorLight,
  //       labelText: 'profile.update.bank_name'.tr,
  //       labelStype: TextAppStyle().genaralTextStyle().copyWith(
  //             color: AppColor.fourthTextColorLight,
  //             fontWeight: FontWeight.w500,
  //           ),
  //       radius: 6,
  //     ),
  //     style: TextStyle(
  //         color: AppColor.dividerColorLight,
  //         fontSize: CommonConstants.smallText,
  //         fontWeight: FontWeight.w400),
  //     validator: (value) =>
  //         (value == null || value.isEmpty) ? 'data_requied'.tr : null,
  //   );
  // }

  Widget _buildInputBranchName() {
    return TextFormField(
      controller: controller.bankBranchName,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        labelText: 'profile.update.branch_name'.tr,
        labelStype: TextAppStyle().genaralTextStyle().copyWith(
              color: AppColor.fourthTextColorLight,
            ),
        radius: 6,
      ),
      style: TextStyle(
          color: AppColor.dividerColorLight,
          fontSize: CommonConstants.smallText,
          fontWeight: FontWeight.w400),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'data_requied'.tr : null,
    );
  }

  Widget _buildInputBankAccount() {
    return TextFormField(
      controller: controller.bankAccountHolder,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        labelText: 'profile.update.bank_account'.tr,
        labelStype: TextAppStyle().genaralTextStyle().copyWith(
              color: AppColor.fourthTextColorLight,
            ),
        radius: 6,
      ),
      style: TextStyle(
          color: AppColor.dividerColorLight,
          fontSize: CommonConstants.smallText,
          fontWeight: FontWeight.w400),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'data_requied'.tr : null,
    );
  }

  Widget _buildInputBankNumber() {
    return Stack(
      children: [
        TextFormField(
          controller: controller.bankAccountNumber,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          cursorColor: AppColor.fifthTextColorLight,
          decoration: TextFieldDecoration.borderOutline(
            backgroundColor: AppColor.primaryBackgroundColorLight,
            borderColor: AppColor.sixTextColorLight,
            labelText: 'profile.update.bank_number'.tr,
            labelStype: TextAppStyle().genaralTextStyle().copyWith(
                  color: AppColor.fourthTextColorLight,
                ),
            radius: 6,
          ),
          style: TextStyle(
              color: AppColor.dividerColorLight,
              fontSize: CommonConstants.smallText,
              fontWeight: FontWeight.w400),
          validator: (value) =>
              (value == null || value.isEmpty) ? 'data_requied'.tr : null,
        ),
      ],
    );
  }

  Widget _buildInputAddressCode() {
    return TextFormField(
      controller: controller.zipCode,
      onChanged: (value) {
        controller.loadAddress(value);
      },
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        labelText: 'profile.update.address_code'.tr,
        labelStype: TextAppStyle().smallTextGrey(),
        radius: 6,
      ),
      style: TextAppStyle().smallTextBlack(),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'data_requied'.tr : null,
    );
  }

  Widget _buildInputTemplate({
    required TextEditingController textEditng,
    required String title,
    FocusNode? focusNode,
  }) {
    return TextFormField(
      controller: textEditng,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.fifthTextColorLight,
      decoration: TextFieldDecoration.borderOutline(
        backgroundColor: AppColor.primaryBackgroundColorLight,
        borderColor: AppColor.sixTextColorLight,
        labelText: title,
        labelStype: TextAppStyle().smallTextGrey(),
        radius: 6,
      ),
      style: TextAppStyle().smallTextBlack(),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'data_requied'.tr : null,
    );
  }

  Widget _buildInputTextArea({
    required TextEditingController textEditng,
    required String title,
  }) {
    return Container(
      child: GFBorder(
        dashedLine: const [4, 6],
        radius: const Radius.circular(6),
        strokeWidth: 2,
        type: GFBorderType.rect,
        color: AppColor.borderGrayColorLight,
        child: TextFormField(
          controller: textEditng,
          keyboardType: TextInputType.text,
          cursorColor: AppColor.fifthTextColorLight,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextAppStyle().normalTextGrey(),
            border: InputBorder.none,
          ),
          style: TextAppStyle().normalTextStype(),
          validator: (value) =>
              (value == null || value.isEmpty) ? 'data_requied'.tr : null,
        ),
      ),
    );
  }

  Widget _buildInputRadio() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: GeneralButton(
              onPressed: () {
                if (controller.genderId.value != CommonConstants.male) {
                  controller.selectGender(CommonConstants.male);
                }
              },
              borderRadius: BorderRadius.circular(4),
              borderColor: AppColor.primaryColorLight,
              backgroundColor: controller.genderId.value == CommonConstants.male
                  ? AppColor.primaryColorLight
                  : null,
              height: 31,
              child: Text(
                'profile.male'.tr,
                style: controller.genderId.value == CommonConstants.male
                    ? TextAppStyle().titleButtonStyle()
                    : TextAppStyle().titleButtonPinkStyle(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            // ignore: unrelated_type_equality_checks
            child: GeneralButton(
              onPressed: () {
                if (controller.genderId.value != CommonConstants.female) {
                  controller.selectGender(CommonConstants.female);
                }
              },
              borderRadius: BorderRadius.circular(4),
              borderColor: AppColor.primaryColorLight,
              backgroundColor:
                  controller.genderId.value == CommonConstants.female
                      ? AppColor.primaryColorLight
                      : null,
              height: 31,
              child: Text(
                'profile.female'.tr,
                style: controller.genderId.value == CommonConstants.female
                    ? TextAppStyle().titleButtonStyle()
                    : TextAppStyle().titleButtonPinkStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageList({
    required String firstImage,
    String? firstImageTitle,
    Function()? onPressBefore,
    required String secondImage,
    String? secondImageTitle,
    Function()? onPressAfter,
    double? height,
  }) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: _buildImageItem(
                image: firstImage,
                title: firstImageTitle,
                onPress: onPressBefore,
                height: height),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildImageItem(
                image: secondImage,
                title: secondImageTitle,
                onPress: onPressAfter,
                height: height),
          ),
        ],
      ),
    );
  }

  Widget _buildImageItem(
      {required String image,
      File? file,
      String? title,
      String? current_image,
      Function()? onPress,
      double? height}) {
    return Column(
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            height: height ?? 119,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: file != null
                  ? Image.file(
                      file,
                      fit: BoxFit.cover,
                    )
                  : current_image != ''
                      ? NetWorkImage(
                          image: current_image!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : FCoreImage(
                          image,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (title != null)
          Column(
            children: [
              Text(
                title,
                style: TextAppStyle().genaralTextStyle(),
              ),
              const SizedBox(height: 12),
            ],
          ),
      ],
    );
  }

  Widget buildSuggestAddress() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'booking.suggest'.tr,
                  style: TextAppStyle()
                      .smallTextBlack()
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: InkWell(
                    onTap: () {
                      controller.closeSuggest();
                    },
                    child: FCoreImage(IconConstants.iconCLose)),
              ),
            ],
          ),
          ...List.generate(
            controller.addressList.length,
            (int index) => InkWell(
              onTap: () {
                controller.selectAddress(controller.addressList[index]);
              },
              child: Container(
                width: Get.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text(
                  controller.addressList[index].fullAddress!,
                  style: TextAppStyle().smallTextBlack(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
