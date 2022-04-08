import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';
import 'package:ui_api/models/invoice/invoice_status.dart';

import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../resource/assets_constant/images_constants.dart';
import '../../../routes/app_pages.dart';
import '../../constants/colors.dart';
import '../../constants/common.dart';
import '../../styles/text_style/text_style.dart';
import '../../widgets/image_widget/fcore_image.dart';
import '../image_widget/network_image.dart';

class ItemOrderWidget extends StatelessWidget {
  const ItemOrderWidget({
    Key? key,
    required this.invoice,
    required this.onPress,
    required this.onAccept,
    required this.onCancel,
    required this.onChat,
    required this.onCall,
    required this.onVideo,
  }) : super(key: key);

  final InvoiceModel invoice;
  final Function() onPress;
  final Function() onAccept;
  final Function() onCancel;

  final Function() onChat;
  final Function() onCall;
  final Function() onVideo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 14),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.secondColorLight.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 26),
                        width: 80,
                        height: 80,
                        child: (invoice.customerAvatar != null &&
                                invoice.customerAvatar != '')
                            ? NetWorkImage(
                                image: invoice.customerAvatar ?? '',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                radius: 8,
                              )
                            : FCoreImage(
                                ImageConstants.emptyImage,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    invoice.code ?? '',
                                    style: TextAppStyle()
                                        .normalTextPink()
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: invoice.workingForm ==
                                                  CommonConstants.online
                                              ? AppColor.onlineColor
                                              : AppColor.offlineColor,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Text(
                                        invoice.workingForm ==
                                                CommonConstants.online
                                            ? 'Online'
                                            : 'Offline',
                                        style: TextAppStyle().normalTextWhite(),
                                      ))
                                ],
                              ),
                              Text(
                                invoice.customerName ?? '',
                                style: TextAppStyle().normalTextStype(),
                              ),
                              const SizedBox(height: 5),
                              (invoice.workingForm == CommonConstants.offline)
                                  ? _buildAddressItem(
                                      icon: IconConstants.icAddress,
                                      title: invoice.customerAddress!)
                                  : Container(),
                              const SizedBox(height: 5),
                              (invoice.workingForm == CommonConstants.offline)
                                  ? _buildAddressItem(
                                      icon: IconConstants.icTrain,
                                      title:
                                          invoice.customerTubeStationNearest!)
                                  : Container(),
                              const SizedBox(height: 5),
                              _buildAddressItem(
                                  icon: IconConstants.icService,
                                  title: invoice.serviceName!),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CommonConstants.paddingDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 11),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColorLight,
                              borderRadius: BorderRadius.circular(80)),
                          child: Row(
                            children: [
                              FCoreImage(
                                IconConstants.icCalendarWhite,
                                width: 12,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                invoice.workingDate ?? '',
                                style: TextAppStyle()
                                    .smallTextStype()
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 11),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColorLight,
                              borderRadius: BorderRadius.circular(80)),
                          child: Row(
                            children: [
                              FCoreImage(
                                IconConstants.icClockWhite,
                                width: 12,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                invoice.workingTime ?? '',
                                style: TextAppStyle()
                                    .smallTextStype()
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (invoice.status == InvoiceStatus.requested.id)
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                                onPress: onCancel,
                                title: 'order.detail.cancel'.tr,
                                style: TextAppStyle()
                                    .smallTextBlack()
                                    .copyWith(fontWeight: FontWeight.w500),
                                border: Border(
                                  right: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 0.5,
                                  ),
                                  top: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 1,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: _buildActionButton(
                                onPress: onAccept,
                                title: 'order.detail.accept'.tr,
                                style: TextAppStyle().smallTextPink(),
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 1,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),

                  if (invoice.status == InvoiceStatus.accepted.id)
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                                onPress: onChat,
                                icon: IconConstants.icChatColor,
                                title: 'order.detail.chat'.tr,
                                border: Border(
                                  right: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 0.5,
                                  ),
                                  top: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 1,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: _buildActionButton(
                                onPress: onCall,
                                icon: IconConstants.icCallColor,
                                title: 'order.detail.call'.tr,
                                border: Border(
                                  right: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 0.5,
                                  ),
                                  top: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 1,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: _buildActionButton(
                                onPress: onVideo,
                                icon: IconConstants.icVideoCallColor,
                                title: 'order.detail.video'.tr,
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.primaryColorLight,
                                    width: 1,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )

                  // Container(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: _buildActionButton(
                  //       onPress: () {},
                  //       icon: IconConstants.icCalendarPink,
                  //       title: 'supplier.book'.tr,
                  //       border: Border(
                  //         top: BorderSide(
                  //           color: AppColor.primaryColorLight,
                  //           width: 1,
                  //         ),
                  //       )),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressItem({required String icon, required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: Image.asset(
            icon,
            width: 15,
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: TextAppStyle().smallTextGrey(),
          ),
        )
      ],
    );
  }

  Widget _buildActionButton(
      {String? icon,
      required String title,
      required Border border,
      TextStyle? style,
      required Function()? onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: border,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && icon != '')
              Image.asset(
                icon,
                width: 17,
              ),
            const SizedBox(width: 10),
            Text(title, style: style ?? TextAppStyle().smallTextBlack())
          ],
        ),
      ),
    );
  }
}
