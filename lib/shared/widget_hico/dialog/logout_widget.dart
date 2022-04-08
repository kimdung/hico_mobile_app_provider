import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../button/general_button.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 14),
                Text(
                  'Đăng xuất',
                  textAlign: TextAlign.center,
                  style: TextAppStyle().largeTextStype(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bạn có chắc muốn đăng xuất ngay bây giờ?',
                  textAlign: TextAlign.center,
                  style: TextAppStyle().normalTextGrey(),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GeneralButton(
                  borderColor: AppColor.primaryColorLight,
                  backgroundColor: AppColor.primaryColorLight,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Từ chối',
                    style: TextAppStyle().normalTextWhite(),
                  ),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: GeneralButton(
                  borderColor: AppColor.primaryColorLight,
                  backgroundColor: AppColor.primaryColorLight,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Text(
                    'Đồng ý',
                    style: TextAppStyle().normalTextWhite(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
