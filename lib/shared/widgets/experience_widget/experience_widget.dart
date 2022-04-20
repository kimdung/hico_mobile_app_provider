import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({Key? key, required this.content}) : super(key: key);

  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 6.0, top: 11.0, bottom: 11.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: AppColor.grayF2F2F2,
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 12.0,
          fontFamily: 'SVN-Jeko',
          fontWeight: FontWeight.w400,
          color: AppColor.eightTextColorLight,
        ),
      ),
    );
  }
}
