import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource/assets_constant/images_constants.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';
import '../../call/pickup/picker_layout.dart';
import '../controllers/update_service_controller.dart';

class UpdateServiceSuccessScreen extends GetView<UpdateServiceController> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      controller.callMethods,
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FCoreImage(ImageConstants.appLogo, height: 42,),
              const SizedBox(height: 18),
              Text('service.time.approve'.tr, style: TextAppStyle().normalTextStype(),),
              Text('service.time.approve_waiting'.tr, style: TextAppStyle().normalTextStype(),),
              const SizedBox(height: 29),
              FCoreImage('lib/resource/assets_resources/icons/loading.png', height: 22,),
            ],
          ),
        ),
      ),
    );
  }
}
