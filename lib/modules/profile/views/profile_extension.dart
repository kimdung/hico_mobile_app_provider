part of 'profile_screen.dart';

extension ProfileExtension on ProfileScreen {
  Widget buildItem({
    required String icon,
    required String title,
    String? description,
    String? description2,
    String? description3,
    String? description4,
    Function()? onPress,
    Color? titleColor,
    int? allowArrow = 1,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColor.borderGrayColorLight,
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 14, top: 4),
                child: FCoreImage(icon)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextAppStyle().genaralTextStyle().copyWith(
                          color: titleColor ?? Colors.black,
                        ),
                  ),
                  Container(
                    child: (description != '')
                        ? Text(
                            description ?? '',
                            style: TextAppStyle().genaralTextStyle().copyWith(
                                  color: titleColor ??
                                      AppColor.eightTextColorLight,
                                ),
                          )
                        : Container(),
                  ),
                  Container(
                    child: (description2 != null && description2 != '')
                        ? Text(
                            description2,
                            style: TextAppStyle().genaralTextStyle().copyWith(
                                  color: titleColor ??
                                      AppColor.eightTextColorLight,
                                ),
                          )
                        : Container(),
                  ),
                  Container(
                    child: (description3 != null && description3 != '')
                        ? Text(
                            description3,
                            style: TextAppStyle().genaralTextStyle().copyWith(
                                  color: titleColor ??
                                      AppColor.eightTextColorLight,
                                ),
                          )
                        : Container(),
                  ),
                  Container(
                    child: (description4 != null && description4 != '')
                        ? Text(
                            description4,
                            style: TextAppStyle().genaralTextStyle().copyWith(
                                  color: titleColor ??
                                      AppColor.eightTextColorLight,
                                ),
                          )
                        : Container(),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageList({
    required String title,
    required String firstImage,
    String? firstImageTitle,
    required String secondImage,
    String? secondImageTitle,
  }) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextAppStyle().genaralBlackTextStyle()),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColor.borderGrayColorLight,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildImageItem(
                      image: firstImage, title: firstImageTitle),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildImageItem(
                      image: secondImage, title: secondImageTitle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageGrid({
    required String title,
    List<DocumentsCertificateModel>? list,
  }) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextAppStyle().genaralBlackTextStyle()),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            color: Colors.white,
            child: list != null && list.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 2,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ...List.generate(
                        list.length,
                        (int index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: NetWorkImage(
                            image: list[index].url!,
                            height: 119,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget _buildImageItem({
    required String image,
    String? title,
  }) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 119,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: (image != '')
                ? NetWorkImage(
                    image: image,
                    fit: BoxFit.cover,
                  )
                : FCoreImage(ImageConstants.defaultImage),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title ?? '',
          style: TextAppStyle().genaralTextStyle(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

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

  Widget _buildInputTextArea({
    required TextEditingController textEditng,
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
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: TextAppStyle().normalTextStype(),
          validator: (value) =>
              (value == null || value.isEmpty) ? 'data_requied'.tr : null,
        ),
      ),
    );
  }
}
