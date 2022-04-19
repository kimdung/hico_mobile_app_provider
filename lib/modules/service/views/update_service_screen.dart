import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hico/shared/constants/common.dart';
import 'package:hico/shared/widget_hico/box_decoration/box_decoration.dart';
import 'package:hico/shared/widget_hico/button/general_button.dart';
import 'package:ui_api/models/user/user_services_model.dart';
import 'package:ui_api/models/user/user_time_model.dart';
import 'package:ui_api/models/user/workplaces_model.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../../call/pickup/picker_layout.dart';
import '../controllers/update_service_controller.dart';

part 'update_service_component.dart';

class UpdateServiceScreen extends GetView<UpdateServiceController> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      controller.callMethods,
      scaffold: Scaffold(
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
            'service.titlebar'.tr,
            style: TextAppStyle().titleAppBarStyle(),
          ),
          elevation: 4,
          backgroundColor: Colors.white,
          shadowColor: AppColor.appbarColorLight.withOpacity(0.8),
        ),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  Container(
                    color: AppColor.greyBackgroundColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 11),
                            child: FCoreImage(IconConstants.icCheckCircle)),
                        Expanded(
                          child: Text(
                            'service.title'.tr,
                            style: TextAppStyle().secondTextStyle().copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CommonConstants.paddingDefault),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        buildTitleComponent(
                          title: 'service'.tr,
                          prefixIcon: true,
                          onPress: () {
                            controller.addService();
                          },
                        ),
                        const SizedBox(height: 14),
                        Container(
                          child: controller.lstServiceUser.isNotEmpty
                              ? Column(
                                  children: [
                                    ...List.generate(
                                        controller.lstServiceUser.length,
                                        (index) => buildServiceItem(
                                            item: controller
                                                .lstServiceUser[index]))
                                  ],
                                )
                              : Container(),
                        ),
                        const SizedBox(height: 16),
                        buildTitleComponent(
                          title: 'service.address'.tr,
                          prefixIcon: true,
                          onPress: () {
                            controller.addWorkplaces();
                          },
                        ),
                        const SizedBox(height: 14),
                        Container(
                          child: controller.lstWorkplaces.isNotEmpty
                              ? Column(
                                  children: [
                                    ...List.generate(
                                        controller.lstWorkplaces.length,
                                        (index) => buildAddressItem(
                                            workplacesItem: controller
                                                .lstWorkplaces[index]))
                                  ],
                                )
                              : Container(),
                        ),
                        const SizedBox(height: 16),
                        buildTitleComponent(
                          title: 'service.time_slot'.tr,
                          prefixIcon: true,
                          onPress: () {
                            controller.addUserTime();
                          },
                        ),
                        const SizedBox(height: 14),
                        Container(
                          child: controller.lstUserTimes.isNotEmpty
                              ? Column(
                                  children: [
                                    ...List.generate(
                                        controller.lstUserTimes.length,
                                        (index) => buildTimeItem(
                                            timeItem:
                                                controller.lstUserTimes[index],
                                            index: index))
                                  ],
                                )
                              : Container(),
                        ),
                        const SizedBox(height: 34),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: CommonConstants.paddingDefault),
                          child: GeneralButton(
                            onPressed: () {
                              controller.save();
                            },
                            borderRadius: BorderRadius.circular(24),
                            borderColor: AppColor.primaryColorLight,
                            backgroundColor: AppColor.primaryColorLight,
                            child: Text(
                              'save'.tr,
                              style: TextAppStyle().titleButtonStyle(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
