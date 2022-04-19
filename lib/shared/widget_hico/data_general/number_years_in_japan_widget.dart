import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/profile/controllers/profile_update_controller.dart';
import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../button/general_button.dart';

class NumberYearsInJapanWidget extends StatelessWidget {
  const NumberYearsInJapanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileUpDateController>();
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 16.0,
        right: 16.0,
        bottom: 12.0,
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  'Số năm ở Nhật',
                  style: TextAppStyle().titleAppBarStyle(),
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.5,
                      bottom: 6.5,
                    ),
                    child: Text(
                      controller.numberYearsInJapanList[index].toString(),
                      style: TextAppStyle().genaralTextStyle(),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) => const Divider(
                color: Color(0xFFC4C4C4),
              ),
              itemCount: controller.numberYearsInJapanList.length,
            ),
            const SizedBox(
              height: 28.0,
            ),
            GeneralButton(
              onPressed: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(24),
              borderColor: AppColor.primaryColorLight,
              backgroundColor: AppColor.primaryColorLight,
              child: Text(
                'Lưu',
                style: TextAppStyle().titleButtonStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
