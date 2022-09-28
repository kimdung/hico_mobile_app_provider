import 'package:get/get.dart';

import '../../../../base/base_binding.dart';
import '../controllers/time_service_controller.dart';

class TimeServiceBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<TimeServiceController>(() => TimeServiceController());
  }
}
