import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';

import '../../../modules/order/controllers/order_controller.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../button/general_button.dart';

class SummaryWorkingWidget extends StatelessWidget {
  const SummaryWorkingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 9.0),
          SvgPicture.asset(IconConstants.icDocumentEdit),
          const SizedBox(height: 8.0),
          Text(
            'dialog.summary'.tr,
            style: TextAppStyle().normalTextStype(),
          ),
          const SizedBox(height: 9.0),
          Container(
            margin: const EdgeInsets.only(
              bottom: 19.0,
              left: 10.0,
              right: 10.0,
            ),
            child: GFBorder(
              dashedLine: const [4, 6],
              radius: const Radius.circular(6),
              strokeWidth: 2,
              type: GFBorderType.rect,
              color: AppColor.borderGrayColorLight,
              child: TextFormField(
                controller: controller.summaryControler,
                keyboardType: TextInputType.text,
                cursorColor: AppColor.fifthTextColorLight,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'dialog.summary.hint'.tr,
                  hintStyle: TextAppStyle().normalTextGrey(),
                  border: InputBorder.none,
                ),
                style: TextAppStyle().normalTextStype(),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'data_requied'.tr : null,
              ),
            ),
          ),
          GeneralButton(
            onPressed: () {
              Navigator.of(context)
                  .pop<String>(controller.summaryControler.text);
            },
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0)),
            borderColor: AppColor.primaryColorLight,
            backgroundColor: AppColor.primaryColorLight,
            child: Text(
              'medical.send'.tr,
              style: TextAppStyle().titleButtonStyle(),
            ),
          )
        ],
      ),
    );
  }
}
