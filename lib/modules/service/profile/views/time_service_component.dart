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
              child: Text(title, style: TextAppStyle().normalTextStype()),
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
    required int parentIndex,
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
                    controller.showTimeFrom(context, parentIndex, index);
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
                    controller.showTimeTo(context, parentIndex, index);
                  },
                  alignment: MainAxisAlignment.end,
                  title: 'supplier.filter.to'.tr,
                  value: time.endTime ?? '',
                ),
              ),
              const SizedBox(width: 40),
              InkWell(
                onTap: () {
                  controller.removeItem(parentIndex, index);
                },
                child: FCoreImage(IconConstants.icClose),
              )
            ],
          ),
          const SizedBox(height: 10),
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
                  type: CommonConstants.online,
                  index: index,
                  parentIndex: parentIndex,
                ),
                buildRadioComponent(
                  value: time.checkOffline ?? 0,
                  type: CommonConstants.offline,
                  index: index,
                  parentIndex: parentIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRadioComponent({
    required int value,
    required int type,
    required int parentIndex,
    required int index,
  }) {
    return InkWell(
      onTap: () => controller.selectRadio(type, parentIndex, index),
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
          Text(
            type == 1 ? 'Có' : 'Không',
            style: TextAppStyle().normalTextStype(),
          ),
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

  Widget buildTimeViewComponent({
    required UserTimeModel item,
    required BuildContext context,
    required int parentIndex,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${'day'.tr} ${item.date.toString()}',
              style: TextAppStyle().normalTextStype()),
          const SizedBox(height: 12),
          buildTitleComponent(
            title: 'supplier.filter.time_slot'.tr,
            onPress: () {
              controller.addItem(parentIndex);
            },
          ),
          const SizedBox(height: 12),
          Container(
            child: (item.list != null && item.list!.length > 0)
                ? Column(
                    children: [
                      ...List.generate(
                        item.list!.length,
                        (index) => buildUserTimeItem(
                          context: context,
                          parentIndex: parentIndex,
                          index: index,
                          time: item.list![index],
                        ),
                      )
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildCalender() {
    return Container(
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          controller.selectDate(date);
        },
        headerTextStyle: TextAppStyle().largeTextStype(),
        weekdayTextStyle: const TextStyle(color: Colors.black),
        weekendTextStyle: const TextStyle(color: Colors.black),
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        height: 420,
        dayPadding: 1,
        todayBorderColor: Colors.grey,
        todayButtonColor: Colors.white,
        todayTextStyle: TextAppStyle().normalTextStype(),
        selectedDateTime: controller.currentDate.value,
        selectedDayButtonColor: Colors.white, // AppColor.primaryColorLight,
        selectedDayBorderColor: Colors.grey, // AppColor.primaryColorLight,
        daysHaveCircularBorder: false,
        markedDatesMap: controller.markedDate.value.dates,
        markedDateShowIcon: true,
        markedDateIconMargin: 0,
        markedDateIconOffset: 0,
        selectedDayTextStyle: const TextStyle(
          color: Colors.black,
        ),
        markedDateIconBorderColor: AppColor.primaryColorLight,
        markedDateIconBuilder: (event) {
          return Container(
            color: AppColor.primaryColorLight,
            child: Center(
                child: Text(
              event.title.toString(),
              style: TextAppStyle().normalTextWhite(),
            )),
          );
        },
        markedDateMoreShowTotal: false,
      ),
    );
  }
}
