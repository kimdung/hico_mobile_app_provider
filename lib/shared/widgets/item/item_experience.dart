import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../modules/profile/controllers/profile_update_controller.dart';
import '../../styles/text_style/text_style.dart';

class ItemExperience extends StatelessWidget {
  const ItemExperience({Key? key, required this.content}) : super(key: key);

  final String content;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileUpDateController>();
    return InkWell(
      onTap: () {
        controller.resultValue.value = content;
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.5,
          bottom: 6.5,
        ),
        child: Text(
          content,
          style: TextAppStyle().genaralTextStyle(),
        ),
      ),
    );
  }
}
