import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../button/general_button.dart';

class SummaryWorkingWidget extends StatelessWidget {
  const SummaryWorkingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(IconConstants.icDocumentEdit),
          const SizedBox(height: 8.0),
          Text(
            'dialog.summary'.tr,
            style: TextAppStyle().normalTextStype(),
          ),
          const SizedBox(height: 9.0),
          Container(
            child: GFBorder(
              dashedLine: const [4, 6],
              radius: const Radius.circular(6),
              strokeWidth: 2,
              type: GFBorderType.rect,
              color: AppColor.borderGrayColorLight,
              child: TextFormField(
                controller: TextEditingController(text: ''),
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
              
            },
            borderRadius: BorderRadius.circular(24),
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
