import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hico/shared/constants/colors.dart';
import 'package:hico/shared/styles/text_style/text_style.dart';

class CancelInvoiceWidget extends StatelessWidget {
  const CancelInvoiceWidget({
    Key? key,
    this.total,
    this.isFined,
  }) : super(key: key);

  final int? isFined;
  final double? total;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (isFined == 0)
          ? Column(
              children: [
                Text(
                  'order.detail.cancel_msg'.tr,
                  textAlign: TextAlign.center,
                  style: TextAppStyle().normalTextStype(),
                ),
                const SizedBox(height: 4),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'note'.tr,
                    style: TextAppStyle()
                        .smallTextBlack()
                        .copyWith(color: AppColor.redTextColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'order.detail.cancel_warning'.tr,
                        style: TextAppStyle().smallTextBlack(),
                      ),
                    ],
                  ),
                )
              ],
            )
          : RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'order.detail.cancel_not_refund'.tr,
                style: TextAppStyle().normalTextStype(),
                children: <TextSpan>[
                  TextSpan(
                      text: ' $total JPY ',
                      style: TextStyle(color: AppColor.redTextColor)),
                  TextSpan(text: 'order.detail.cancel_not_refund_ctn'.tr),
                ],
              ),
            ),
    );
  }
}
