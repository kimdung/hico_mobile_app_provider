import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/user/user_services_model.dart';
import 'package:ui_api/models/user/user_time_model.dart';
import 'package:ui_api/models/user/workplaces_model.dart';

import '/resource/assets_constant/images_constants.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widget_hico/box_decoration/box_decoration.dart';
import '../../../shared/widget_hico/button/general_button.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../../call/pickup/picker_layout.dart';
import '../controllers/service_controller.dart';

part 'service_extension.dart';

class ServiceScreen extends GetView<ServiceController> {
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
          child: Container(
            child: Column(
              children: [
                Obx(
                  () => controller.info.value.services != null &&
                          controller.info.value.services!.isNotEmpty
                      ? buildListService()
                      : buildEmptyPage(),
                ),
                const SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CommonConstants.paddingDefault),
                  child: GeneralButton(
                    onPressed: () {
                      controller.edit();
                    },
                    borderRadius: BorderRadius.circular(24),
                    borderColor: AppColor.primaryColorLight,
                    borderWidth: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FCoreImage(IconConstants.icAdd),
                        const SizedBox(width: 18),
                        Text(
                          'service.add'.tr,
                          style: TextAppStyle().titleButtonStyle().copyWith(
                                color: AppColor.primaryTextColorLight,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
