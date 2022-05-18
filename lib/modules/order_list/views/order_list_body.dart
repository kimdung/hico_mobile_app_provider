part of 'order_list_screen.dart';

extension OrderListBody on OrderListScreen {
  Widget _buildHeaderBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.toNamed(Routes.PROFILE),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: CachedNetworkImage(
                width: 42,
                height: 42,
                imageUrl: AppDataGlobal.userInfo?.avatarImage ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'order.hello'.tr,
                  style: AppTextStyle.secondTextStyle
                      .copyWith(color: AppColor.eightTextColorLight),
                ),
                Text(
                  AppDataGlobal.userInfo?.name ?? '',
                  style: AppTextStyle.primaryTextStyle
                      .copyWith(color: AppColor.niceTextColorLight),
                ),
                Row(
                  children: [
                    FCoreImage(
                      IconConstants.icWallet,
                      width: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${controller.info.value.accountBalance ?? 0} JPY',
                      style: TextAppStyle().smallTextPink(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          InkWell(
            onTap: (){
              controller.deposit();
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              child: FCoreImage(
                IconConstants.icWallet2,
                height: 24,
              ),
            ),
          ), 
          InkWell(
            onTap: controller.onChatAdmin,
            child: Stack(
              children: [
                Container(
                 margin: const EdgeInsets.all(5),
                  child: FCoreImage(
                    IconConstants.icChat,
                    height: 24,
                  ),
                ),
                controller.totalNotif.value == 0
                    ? Container()
                    : Positioned(
                        right: 0, 
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColor.primaryColorLight),
                          child: Center(
                            child: Text(
                              controller.totalNotif.value.toString(),
                              style: AppTextStyle.secondTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      color: AppColor.secondBackgroundColorLight,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 22),
            height: 46,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )),
          ),
          Positioned(
            //top: -22,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.paddingDefault),
              width: Get.width,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColor.primaryColorLight,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                onSubmitted: controller.onSearch,
                cursorColor: AppColor.primaryColorLight,
                style: TextAppStyle().normalTextPink(),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'order.search_title'.tr,
                  prefixIcon: Image.asset(IconConstants.icSearch),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 35,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.invoiceStatus.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Obx(() {
              final status = controller.invoiceStatus[index];
              return Container(
                margin: const EdgeInsets.only(left: 20),
                child: ButtonScale(
                  onPressed: () => controller.selectStatus(status),
                  borderRadius: BorderRadius.circular(40),
                  borderColor: AppColor.primaryColorLight,
                  backgroundColor: status == controller.currentStatus.value
                      ? AppColor.primaryColorLight
                      : AppColor.primaryBackgroundColorLight,
                  height: 35,
                  child: Text(
                    controller.invoiceStatus[index].name.tr,
                    style: TextAppStyle().titleButtonStyle().copyWith(
                          fontSize: 14,
                          color: status == controller.currentStatus.value
                              ? Colors.white
                              : AppColor.primaryTextColorLight,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildListOrder() {
    return Container(
      color: AppColor.primaryBackgroundColorLight,
      child: Column(
        children: [
          ...List.generate(
              controller.list.length,
              (index) => ItemOrderWidget(
                    invoice: controller.list[index],
                    onPress: () {
                      controller.viewDetail(controller.list[index].id!);
                    },
                    onAccept: () {
                      controller.confirm(
                          controller.list[index].id!, InvoiceStatus.accepted);
                    },
                    onCancel: () {
                      controller.confirm(
                          controller.list[index].id!, InvoiceStatus.canceled);
                    },
                    onChat: () => controller.onChat(controller.list[index]),
                    onCall: () => controller.onCall(controller.list[index]),
                    onVideo: () => controller.onVideo(controller.list[index]),
                  ))
        ],
      ),
    );
  }
}
