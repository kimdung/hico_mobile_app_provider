part of 'medical_screen.dart';

extension MedicalScreenExtension on MeidcalScreen {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        'medical.title'.tr,
        style: TextAppStyle().titleAppBarStyle(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 40.0,
      color: AppColor.greyBackgroundColor,
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 20.0,
        right: 27.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(IconConstants.icDocumentEdit),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              'medical.header'.tr,
              style: TextAppStyle().headerTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputTextArea({
    required TextEditingController textEditng,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextAppStyle().titleTextStyle()),
        const SizedBox(height: 8),
        Container(
          child: GFBorder(
            dashedLine: const [4, 6],
            radius: const Radius.circular(6),
            strokeWidth: 2,
            type: GFBorderType.rect,
            color: AppColor.borderGrayColorLight,
            child: TextFormField(
              controller: textEditng,
              enableInteractiveSelection: true,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              cursorColor: AppColor.fifthTextColorLight,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: description,
                hintStyle: TextAppStyle().normalTextGrey(),
                border: InputBorder.none,
              ),
              style: TextAppStyle().normalTextStype(),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'data_requied'.tr : null,
            ),
          ),
        ),
      ],
    );
  }
}
