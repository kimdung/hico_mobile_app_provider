import 'package:get/get.dart';
import '../../../base/base_binding.dart';

import '../controllers/notification_controller.dart';

class NotificationBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
