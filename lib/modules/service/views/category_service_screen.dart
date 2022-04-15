import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widget_hico/box_decoration/box_decoration.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../../call/pickup/picker_layout.dart';
import '../controllers/category_service_controller.dart';

part 'category_service_component.dart';

class CategoryServiceScreen extends GetView<CategoryServiceController> {
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
            'service.category.service_list'.tr,
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
                        if (controller.serviceCategories.isNotEmpty)
                          ...List.generate(
                            controller.serviceCategories.length,
                            (int index) => buildTitleComponent(
                              title: controller.serviceCategories[index].name ??
                                  '',
                              prefixIcon: true,
                              onPress: () {
                                controller.getService(
                                  context,
                                  controller.serviceCategories[index].id ?? 0,
                                  controller.serviceCategories[index].name ??
                                      '',
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 34),
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
