part of 'service_screen.dart';

extension ServiceExtension on ServiceScreen {
  Widget buildEmptyPage() {
    return Container(
      child: Column(
        children: [
          Container(
            color: AppColor.greyBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: FCoreImage(IconConstants.icCheckCircle)),
                Expanded(
                  child: Text(
                    'service.title'.tr,
                    style: TextAppStyle().secondTextStyle().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 100),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FCoreImage(
                    ImageConstants.serviceEmpty,
                    width: 110,
                  ),
                  const SizedBox(height: 18),
                  Text('service.empty'.tr,
                      textAlign: TextAlign.center,
                      style: TextAppStyle().genaralTextStyle()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListService() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CommonConstants.paddingDefault),
      child: Column(
        children: [
          const SizedBox(height: 30),
          buildTitleComponent(title: 'service'.tr, prefixIcon: false),
          const SizedBox(height: 14),
          Container(
            child: controller.info.value.services != null
                ? Column(
                    children: [
                      ...List.generate(
                          controller.info.value.services!.length,
                          (index) => buildServiceItem(
                              item: controller.info.value.services![index]))
                    ],
                  )
                : Container(),
          ),
          const SizedBox(height: 16),
          buildTitleComponent(title: 'service.address'.tr, prefixIcon: false),
          const SizedBox(height: 14),
          Container(
            child: controller.info.value.workplaces != null
                ? Column(
                    children: [
                      ...List.generate(
                          controller.info.value.workplaces!.length,
                          (index) => buildAddressItem(
                              workplacesItem:
                                  controller.info.value.workplaces![index]))
                    ],
                  )
                : Container(),
          ),
          const SizedBox(height: 16),
          buildTitleComponent(title: 'service.time_slot'.tr, prefixIcon: false),
          const SizedBox(height: 14),
          Container(
            child: controller.info.value.userTime != null
                ? Column(
                    children: [
                      ...List.generate(
                          controller.info.value.userTime!.length,
                          (index) => buildTimeItem(
                              timeItem: controller.info.value.userTime![index]))
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildServiceItem({required UserServicesCategoryModel item}) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'service'.tr} ${item.name}',
                style: TextAppStyle().normalTextPink(),
              ),
              FCoreImage(IconConstants.icArrowDown),
            ],
          ),
          const SizedBox(height: 11),
          Container(
            child: item.list!.isNotEmpty
                ? Column(
                    children: [
                      ...List.generate(
                          item.list!.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.list![index].name ?? '',
                                        style: TextAppStyle().normalTextStype(),
                                      ),
                                    ),
                                    Text(
                                      'Onl',
                                      style: item.list![index].isOnline == 1
                                          ? TextAppStyle().normalTextPink()
                                          : TextAppStyle().normalTextWhite(),
                                    ),
                                    const SizedBox(width: 14),
                                    Text(
                                      'Off',
                                      style: item.list![index].isOffline == 1
                                          ? TextAppStyle().normalTextPink()
                                          : TextAppStyle().normalTextWhite(),
                                    ),
                                  ],
                                ),
                              ))
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildAddressItem({required WorkplacesModel workplacesItem}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workplacesItem.name ?? '',
                style: TextAppStyle().normalTextPink(),
              ),
              FCoreImage(IconConstants.icArrowDown),
            ],
          ),
          const SizedBox(height: 11),
          Container(
            child: workplacesItem.districts!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        workplacesItem.districts!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            workplacesItem.districts![index].name ?? '',
                            style: TextAppStyle().normalTextStype(),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildTimeItem({required UserTimeModel timeItem}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Row(
            children: [
              FCoreImage(
                IconConstants.icCalendarPink,
                width: 18,
              ),
              const SizedBox(width: 6),
              Text(
                timeItem.date ?? '',
                style: TextAppStyle().normalTextStype(),
              ),
            ],
          )),
          const SizedBox(width: 17),
          Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: FCoreImage(
                      IconConstants.icTimeCircle,
                      width: 18,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextAppStyle().normalTextStype(),
                        children: <TextSpan>[
                          ...List.generate(
                            timeItem.list!.length,
                            (int index) => TextSpan(
                              text:
                                  '${timeItem.list![index].beginTime}-${timeItem.list![index].endTime}${(index + 1) == timeItem.list!.length ? '' : ', '}',
                              style: TextAppStyle().normalTextStype(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildTitleComponent({
    required String title,
    bool prefixIcon = true,
    Alignment? alignment,
  }) {
    return BoxDecorationWidget(
      height: 47,
      radius: 8,
      shadow: true,
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
            FCoreImage(
              IconConstants.icArrowDown,
              width: 24,
            ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
