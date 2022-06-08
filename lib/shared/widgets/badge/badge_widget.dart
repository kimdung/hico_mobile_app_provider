import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../styles/text_style/app_text_style.dart';

class BadgeWidget extends StatelessWidget {
  final int badge;

  const BadgeWidget({Key? key, this.badge = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return badge == 0
        ? Container()
        : ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColorLight,
              ),
              child: Center(
                child: Text(
                  badge.toString(),
                  style: AppTextStyle.secondTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
  }
}
