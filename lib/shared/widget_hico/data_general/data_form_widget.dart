import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/time.dart';
import '../../../modules/profile/controllers/profile_update_controller.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../../widgets/image_widget/fcore_image.dart';
import '../button/general_button.dart';

class DataFormWidget extends StatelessWidget {
  const DataFormWidget({Key? key, required this.dataList, required this.title})
      : super(key: key);

  final String title;
  final List<Time> dataList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileUpDateController>(
      init: ProfileUpDateController(),
      builder: (controller) => Padding(
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
                return InkWell(
                  onTap: () {
                    controller.chooseTime(index, dataList);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.5,
                      bottom: 6.5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            dataList[index].content,
                            style: TextAppStyle().genaralTextStyle(),
                          ),
                        ),
                         dataList[index].isFeatured
                            ? FCoreImage(
                                IconConstants.icSuccess,
                                width: 16.0,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
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
                Get.back(result: controller.resultValue.value);
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
      ),
    );
  }
}
