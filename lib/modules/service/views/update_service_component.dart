part of 'update_service_screen.dart';

extension UpdateServiceComponent on UpdateServiceScreen {
  Widget buildServiceItem({required UserServicesCategoryModel item}) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${'service'.tr} ${item.name}',
                  style: TextAppStyle().normalTextPink(),
                ),
              ),
              Text(
                'Onl',
                style: TextAppStyle().normalTextGrey(),
              ),
              const SizedBox(width: 15),
              Text(
                'Off',
                style: TextAppStyle().normalTextGrey(),
              ),
              const SizedBox(width: 35),
            ],
          ),
          const SizedBox(height: 14),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         'all'.tr,
          //         style: TextAppStyle().normalTextPink(),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {},
          //       child: FCoreImage(
          //         IconConstants.icCheckbox,
          //         width: 16,
          //         height: 16,
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //     const SizedBox(width: 20),
          //     InkWell(
          //       onTap: () {},
          //       child: FCoreImage(
          //         IconConstants.icCheckbox,
          //         width: 16,
          //         height: 16,
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //     const SizedBox(width: 20),
          //     const SizedBox(width: 18),
          //   ],
          // ),
          // const SizedBox(height: 11),
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
                                    InkWell(
                                      onTap: () {
                                        controller.changeWorkingForm(
                                          serviceCategoryId:
                                              item.serviceCategoryId!,
                                          serviceId: item.list![index].id!,
                                          type: CommonConstants.online,
                                          value: item.list![index].isOnline == 1
                                              ? 0
                                              : 1,
                                        );
                                      },
                                      child: FCoreImage(
                                        item.list![index].isOnline == 1
                                            ? IconConstants.icCheckedbox
                                            : IconConstants.icCheckbox,
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {
                                        controller.changeWorkingForm(
                                          serviceCategoryId:
                                              item.serviceCategoryId!,
                                          serviceId: item.list![index].id!,
                                          type: CommonConstants.offline,
                                          value:
                                              item.list![index].isOffline == 1
                                                  ? 0
                                                  : 1,
                                        );
                                      },
                                      child: FCoreImage(
                                        item.list![index].isOffline == 1
                                            ? IconConstants.icCheckedbox
                                            : IconConstants.icCheckbox,
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {
                                        controller.removeService(
                                          serviceCategoryId:
                                              item.serviceCategoryId!,
                                          serviceId: item.list![index].id!,
                                        );
                                      },
                                      child: FCoreImage(
                                        IconConstants.icClose,
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.fill,
                                      ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                workplacesItem.districts![index].name ?? '',
                                style: TextAppStyle().normalTextStype(),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.removeDistrict(
                                      workplacesItem.provinceId!,
                                      workplacesItem.districts![index].id!);
                                },
                                child: FCoreImage(
                                  IconConstants.icClose,
                                  width: 18,
                                  height: 18,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
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

  Widget buildTimeItem({required UserTimeModel timeItem, required int index}) {
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
              const SizedBox(width: 4),
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
                  child: Text(
                    timeItem.getTime(),
                    style: TextAppStyle().normalTextStype(),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.removeTime(index);
            },
            child: FCoreImage(
              IconConstants.icClose,
              width: 18,
              height: 18,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitleComponent({
    required String title,
    bool prefixIcon = true,
    Alignment? alignment,
    Function()? onPress,
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
}
