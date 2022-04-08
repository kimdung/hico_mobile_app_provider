import 'package:get/get.dart';

import '../../../base/base_binding.dart';
import '../controller/on_boarding_controller.dart';

class OnBoardingBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}
