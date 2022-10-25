import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/user/user_time_model.dart';

import '../../../../resource/assets_constant/icon_constants.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/styles/text_style/text_style.dart';
import '../../../../shared/widget_hico/box_decoration/box_decoration.dart';
import '../../../../shared/widget_hico/button/general_button.dart';
import '../../../../shared/widgets/image_widget/fcore_image.dart';
import '../../../call/pickup/picker_layout.dart';
import '../controllers/time_service_controller.dart';

part 'time_service_component.dart';

class TimeServiceScreen extends GetView<TimeServiceController> {
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
            'service.time.title'.tr,
            style: TextAppStyle().titleAppBarStyle(),
          ),
          elevation: 4,
          backgroundColor: Colors.white,
          shadowColor: AppColor.appbarColorLight.withOpacity(0.8),
        ),
        body: SingleChildScrollView(
          child: Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildCalender(),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.lstUserTimes.length,
                      itemBuilder: (context, index) =>
                       buildTimeViewComponent(
                        item: controller.lstUserTimes[index],
                        context: context,
                        parentIndex: index,
                      ),
                      separatorBuilder: (context, index) => Container(),
                    ),
                  ],
                ),
              )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: CommonConstants.paddingDefault,
              vertical: CommonConstants.paddingDefault),
          child: GeneralButton(
            onPressed: () {
              controller.comfirm();
            },
            borderRadius: BorderRadius.circular(24),
            borderColor: AppColor.primaryColorLight,
            backgroundColor: AppColor.primaryColorLight,
            child: Text(
              'confirm'.tr,
              style: TextAppStyle().titleButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
