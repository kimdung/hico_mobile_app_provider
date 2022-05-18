part of 'statistic_screen.dart';

extension StatisticExtension on StatisticScreen {
  Widget buildStatusNavBar() {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20.0,
              ),
              InkWell(
                onTap: () {
                  controller.onChangeStatus(0);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: controller.indexStatus.value == 0
                      ? BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48)),
                        )
                      : const BoxDecoration(
                          color: AppColor.primaryPink50,
                          borderRadius: BorderRadius.all(Radius.circular(48)),
                        ),
                  child: Text(
                    'statistic.synthetic'.tr,
                    textAlign: TextAlign.center,
                    style: TextAppStyle().genaralTextStyle().copyWith(
                          color: controller.indexStatus.value == 0
                              ? AppColor.secondTextColorLight
                              : AppColor.primaryTextColorLight,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  controller.onChangeStatus(CommonConstants.statisticCustomerCancel);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: controller.indexStatus.value == CommonConstants.statisticCustomerCancel
                      ? BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48)),
                        )
                      : const BoxDecoration(
                          color: AppColor.primaryPink50,
                          borderRadius: BorderRadius.all(Radius.circular(48)),
                        ),
                  child: Text(
                    'statistic.customer.cancel'.tr,
                    textAlign: TextAlign.center,
                    style: TextAppStyle().genaralTextStyle().copyWith(
                          color: controller.indexStatus.value == CommonConstants.statisticCustomerCancel
                              ? AppColor.secondTextColorLight
                              : AppColor.primaryTextColorLight,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  controller.onChangeStatus(CommonConstants.statisticComplete);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: controller.indexStatus.value == CommonConstants.statisticComplete
                      ? BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48)),
                        )
                      : const BoxDecoration(
                          color: AppColor.primaryPink50,
                          borderRadius: BorderRadius.all(Radius.circular(48)),
                        ),
                  child: Text(
                    'statistic.finish'.tr,
                    textAlign: TextAlign.center,
                    style: TextAppStyle().genaralTextStyle().copyWith(
                          color: controller.indexStatus.value == CommonConstants.statisticComplete
                              ? AppColor.secondTextColorLight
                              : AppColor.primaryTextColorLight,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  controller.onChangeStatus(CommonConstants.statisticSupplierCancel);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: controller.indexStatus.value == CommonConstants.statisticSupplierCancel
                      ? BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48)),
                        )
                      : const BoxDecoration(
                          color: AppColor.primaryPink50,
                          borderRadius: BorderRadius.all(Radius.circular(48)),
                        ),
                  child: Text(
                    'statistic.cancel'.tr,
                    textAlign: TextAlign.center,
                    style: TextAppStyle().genaralTextStyle().copyWith(
                          color: controller.indexStatus.value == CommonConstants.statisticSupplierCancel
                              ? AppColor.secondTextColorLight
                              : AppColor.primaryTextColorLight,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
        ));
  }

  Widget buildTotalWithStatus() {
    return Obx(() => Container(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: controller.indexStatus.value == 0
                ? Column(children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTotalItem(
                            margin: 1,
                            icon: IconConstants.icMoneyGreen,
                            title: 'statistic.wallet'.tr,
                            price:
                                '${controller.statistic.value.balance ?? 0} JPY ',
                            textColor: AppColor.blueTextColor),
                        _buildTotalItem(
                            margin: 2,
                            icon: IconConstants.icMoneyPink,
                            title: 'statistic.system_pay'.tr,
                            price:
                                '${controller.statistic.value.paid ?? 0} JPY ',
                            textColor: AppColor.blueTextColor),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _buildTotalItem(
                            margin: 1,
                            icon: IconConstants.icMoneyPink,
                            title: 'statistic.system_debt'.tr,
                            price:
                                '${controller.statistic.value.remain ?? 0} JPY ',
                            textColor: AppColor.redTextColor),
                      ],
                    )
                  ])
                : controller.indexStatus.value == 3
                    ? Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: _buildTotalItem(
                                  margin: 1,
                                  icon: IconConstants.icMoneyGreen,
                                  title: 'statistic.bonus'.tr,
                                  price:
                                      '${controller.statistic.value.invoiceCancelByCustomer ?? 0} JPY ',
                                  textColor: AppColor.blueTextColor),
                            ),
                          ),
                        ],
                      )
                    : controller.indexStatus.value == 1
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              _buildTotalItem(
                                  margin: 1,
                                  icon: IconConstants.icMoneyGreen,
                                  title: 'statistic.total_amount'.tr,
                                  price:
                                      '${controller.statistic.value.invoiceComplete ?? 0} JPY ',
                                  textColor: AppColor.blueTextColor),
                            ],
                          )
                        : controller.indexStatus.value == 2
                            ? Column(children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildTotalItem(
                                        margin: 1,
                                        icon: IconConstants.icMoneyRed,
                                        title: 'statistic.system_fine'.tr,
                                        price:
                                            '${controller.statistic.value.finedAmount ?? 0} JPY ',
                                        textColor: AppColor.redTextColor),
                                    _buildTotalItem(
                                        margin: 1,
                                        icon: IconConstants.icMoneyGrey,
                                        title: 'statistic.cancel_number'.tr,
                                        price:
                                            '${controller.statistic.value.cancelTimes ?? 0} ${'order.detail.step'.tr} '),
                                  ],
                                ),
                                const SizedBox(height: 14),
                              ])
                            : null,
          ),
        ));
  }

  Widget _buildTotalItem(
      {int? margin = 1,
      required String icon,
      required String title,
      required String price,
      Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: (Get.width - 54) / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondColorLight.withOpacity(0.2),
            //spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 11),
            child: FCoreImage(icon, width: 18),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextAppStyle().secondTextStyle().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  price,
                  style: TextAppStyle().secondTextStyle().copyWith(
                        color: textColor ?? Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.primaryColorLight,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        onSubmitted: (value) {
          controller.loadInvoiceList();
        },
        controller: controller.keyword,
        cursorColor: AppColor.primaryColorLight,
        style: TextAppStyle().smallTextPink(),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: 'order.search_title'.tr,
            hintStyle: TextAppStyle().normalTextPink(),
            prefixIcon: Image.asset(IconConstants.icSearch),
            contentPadding: const EdgeInsets.symmetric(vertical: 5)),
      ),
    );
  }

  Widget buildSearchDate(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: _buildFromDateInput(context)),
          const SizedBox(width: 30),
          Expanded(child: _buildToDateInput(context)),
          const SizedBox(width: 30),
          Container(
            width: 71,
            child: GeneralButton(
              onPressed: () {
                controller.loadInvoiceList();
              },
              borderRadius: BorderRadius.circular(40),
              borderColor: AppColor.primaryColorLight,
              backgroundColor: AppColor.primaryColorLight,
              height: 35,
              child: Text(
                'statistic.select'.tr,
                style: TextAppStyle()
                    .smallTextStype()
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFromDateInput(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'statistic.from_date'.tr,
            style: TextAppStyle().genaralTextStyle().copyWith(
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            color: AppColor.secondBackgroundColorLight,
            height: 35,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectFromDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: controller.fromDateController,
                      keyboardType: TextInputType.datetime,
                      style: TextAppStyle().genaralTextStyle().copyWith(
                            color: AppColor.niceTextColorLight,
                          ),
                      decoration: InputDecoration(
                        hintText: controller.fromDate,
                        hintStyle: TextAppStyle().genaralTextStyle().copyWith(
                              color: AppColor.niceTextColorLight,
                            ),
                        contentPadding: const EdgeInsets.fromLTRB(8, -10, 0, 6),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 4,
                    right: 0,
                    width: 24,
                    child: FCoreImage(
                      IconConstants.icExpandMore,
                      width: 24,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildToDateInput(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'statistic.to_date'.tr,
            style: TextAppStyle().genaralTextStyle().copyWith(
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            color: AppColor.secondBackgroundColorLight,
            height: 35,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectToDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: controller.toDateController,
                      keyboardType: TextInputType.datetime,
                      style: TextAppStyle().genaralTextStyle().copyWith(
                            color: AppColor.niceTextColorLight,
                          ),
                      decoration: InputDecoration(
                        hintText: controller.toDate,
                        hintStyle: TextAppStyle().genaralTextStyle().copyWith(
                              color: AppColor.niceTextColorLight,
                            ),
                        contentPadding: const EdgeInsets.fromLTRB(8, -10, 0, 6),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 4,
                    right: 0,
                    width: 24,
                    child: FCoreImage(
                      IconConstants.icExpandMore,
                      width: 24,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildOrderList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.invoiceList.length,
          itemBuilder: (context, index) {
            return _buildOrderItem(item: controller.invoiceList[index]);
          })),
    );
  }

  Widget _buildOrderItem({required StatisticInvoiceModel item}) {
    return Container(
      //height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondColorLight.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: (item.supplierAvatar != null && item.supplierAvatar != '')
                  ? NetWorkImage(
                      image: item.supplierAvatar!,
                      height: 60,
                    )
                  : FCoreImage(
                      ImageConstants.imageDefault,
                      height: 60,
                    )),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'statistic.order_code'.tr,
                    style: TextAppStyle().smallTextPink(),
                  ),
                  Text(
                    item.code ?? '',
                    style: TextAppStyle().smallTextBlack(),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'statistic.amount'.tr,
                    style: TextAppStyle().smallTextPink(),
                  ),
                  Text(
                    '${item.total} JPY',
                    style: TextAppStyle().smallTextBlack(),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
