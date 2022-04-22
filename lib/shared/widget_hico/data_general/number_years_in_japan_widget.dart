import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../../widgets/item/item_experience.dart';
import '../button/general_button.dart';

class DataFormWidget extends StatelessWidget {
  const DataFormWidget({Key? key, required this.dataList, required this.title, required this.onTap})
      : super(key: key);

  final String title;
  final List<String> dataList;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 16.0,
        right: 16.0,
        bottom: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  title,
                  textAlign: TextAlign.center,
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
                return ItemExperience(content: dataList[index]);
              },
              separatorBuilder: (_, index) => const Divider(
                color: Color(0xFFC4C4C4),
              ),
              itemCount: dataList.length,
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
                'save'.tr,
                style: TextAppStyle().titleButtonStyle(),
              ),
            )
          ],
        ),
    );
  }
}
