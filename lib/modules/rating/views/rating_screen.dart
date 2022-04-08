import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hico/app.dart';
import 'package:hico/resource/assets_constant/images_constants.dart';
import 'package:hico/shared/constants/common.dart';
import 'package:hico/shared/widget_hico/box_decoration/box_decoration.dart';
import 'package:hico/shared/widget_hico/image_widget/network_image.dart';
import 'package:ui_api/models/rating/rating_model.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../controllers/rating_controller.dart';

part 'rating_extension.dart';

class RatingScreen extends GetView<RatingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            IconConstants.icBack,
            width: 11,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'profile.rating'.tr,
          style: TextAppStyle().titleAppBarStyle(),
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        shadowColor: AppColor.appbarColorLight.withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.paddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      starItem(
                          star: 0,
                          onPress: () {
                            controller.selectStar(0);
                          },
                          total: controller.ratingInfo.value.total ?? 0),
                      starItem(
                        star: CommonConstants.fiveStar,
                        onPress: () {
                          controller.selectStar(CommonConstants.fiveStar);
                        },
                        total: controller.ratingInfo.value.totalFifth ?? 0,
                      ),
                      starItem(
                        star: CommonConstants.fourStar,
                        onPress: () {
                          controller.selectStar(CommonConstants.fourStar);
                        },
                        total: controller.ratingInfo.value.totalFourth ?? 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      starItem(
                        star: CommonConstants.threeStar,
                        onPress: () {
                          controller.selectStar(CommonConstants.threeStar);
                        },
                        total: controller.ratingInfo.value.totalThird ?? 0,
                      ),
                      const SizedBox(width: 18),
                      starItem(
                        star: CommonConstants.twoStar,
                        onPress: () {
                          controller.selectStar(CommonConstants.twoStar);
                        },
                        total: controller.ratingInfo.value.totalSecond ?? 0,
                      ),
                      const SizedBox(width: 18),
                      starItem(
                        star: CommonConstants.oneStar,
                        onPress: () {
                          controller.selectStar(CommonConstants.oneStar);
                        },
                        total: controller.ratingInfo.value.totalFirst ?? 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: (controller.ratingInfo.value.rows != null &&
                            controller.ratingInfo.value.rows!.isNotEmpty)
                        ? Column(
                            children: [
                              ...List.generate(
                                  controller.ratingInfo.value.rows!.length,
                                  (index) => ratingItem(
                                      item: controller
                                          .ratingInfo.value.rows![index])),
                            ],
                          )
                        : Container(),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
