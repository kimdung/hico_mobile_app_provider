part of 'time_service_screen.dart';

extension TimeServiceComponent on TimeServiceScreen {
  Widget buildTitleComponent({
    required String title,
    bool prefixIcon = true,
    Alignment? alignment,
    Function()? onPress,
  }) {
    return BoxDecorationWidget(
      height: 47,
      radius: 8,
      shadow: false,
      border: Border.all(color: AppColor.primaryColorLight),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 14),
              alignment: alignment,
              child: Text(title, style: TextAppStyle().normalTextPink()),
            ),
          ),
          if (prefixIcon)
            InkWell(
              onTap: onPress,
              child: FCoreImage(
                IconConstants.icAddNonBorder,
                width: 16,
              ),
            ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget buildUserTimeItem({
    required BuildContext context,
    required int index,
    required UserTimeListModel time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildBoxTimeSection(
                  onPress: () {
                    controller.showTimeFrom(context, index);
                  },
                  title: 'supplier.filter.from'.tr,
                  value: time.beginTime ?? '',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CommonConstants.paddingDefault),
                child: SizedBox(
                  width: 12,
                  height: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
              ),
              Expanded(
                child: buildBoxTimeSection(
                  onPress: () {
                    controller.showTimeTo(context, index);
                  },
                  alignment: MainAxisAlignment.end,
                  title: 'supplier.filter.to'.tr,
                  value: time.endTime ?? '',
                ),
              ),
              const SizedBox(width: 40),
              InkWell(
                onTap: () {
                  controller.removeItem(index);
                },
                child: FCoreImage(IconConstants.icClose),
              )
            ],
          ),
          const SizedBox(height:10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width / 3,
                   // 100,
                  child: Text(
                    'service.update.offline_time'.tr,
                    style: TextAppStyle().normalTextStype(),
                  ),
                ),
                buildRadioComponent(
                  value: time.checkOffline ?? 0,
                  type: 1,
                  index: index,
                ),
                buildRadioComponent(
                    value: time.checkOffline ?? 0, type: 0, index: index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRadioComponent(
      {required int value, required int type, required int index}) {
    return InkWell(
      onTap: () => controller.selectRadio(type, index),
      child: Row(
        children: [
          FCoreImage(
            type.isEqual(value)
                ? IconConstants.icRadioSelected
                : IconConstants.icRadioUnselect,
            fit: BoxFit.fill,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 12),
          Text(type == 1 ? 'Có' : 'Không', style: TextAppStyle().normalTextStype(),),
        ],
      ),
    );
  }

  Widget buildBoxTimeSection({
    MainAxisAlignment? alignment,
    required String title,
    Function()? onPress,
    String? value,
  }) {
    return Container(
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              title,
              style: TextAppStyle().genaralBlackTextStyle(),
            ),
          ),
          Expanded(
            child: buildSelectComponent(
              onPress: onPress,
              title: value ?? '00:00',
              textColor: TextAppStyle().normalTextStype(),
              height: 31,
              prefixIcon: true,
              prefixImage: IconConstants.icExpandMore,
              paddingRight: 6,
            ),
          ),
        ],
      ),
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
      height: height ?? 42,
      shadow: shadow,
      border: border ? Border.all(color: AppColor.borderPinkBoldColor) : null,
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
            SizedBox(width: paddingRight ?? 16),
          ],
        ),
      ),
    );
  }
}
