import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/time.dart';
import '../../../modules/profile/controllers/profile_update_controller.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../styles/text_style/text_style.dart';
import '../image_widget/fcore_image.dart';

class ItemTime extends StatelessWidget {
  const ItemTime({Key? key, required this.time}) : super(key: key);

  final Time time;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileUpDateController>();
    return Padding(
        padding: const EdgeInsets.only(
          top: 16.5,
          bottom: 6.5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                time.content,
                style: TextAppStyle().genaralTextStyle(),
              ),
            ),
            time.isFeatured ? FCoreImage(
                    IconConstants.icSuccess,
                    width: 16.0,
                  )
                : Container(),
          ],
        ),
      );
  }
}
