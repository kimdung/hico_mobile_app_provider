import 'package:get/get.dart';
import '../../../base/base_binding.dart';
import '../controllers/notification_detail_controller.dart';

class NotificationDetailBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<NotificationDetailController>(
        () => NotificationDetailController());
  }
}
