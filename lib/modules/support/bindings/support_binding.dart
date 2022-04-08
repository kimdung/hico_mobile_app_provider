import 'package:get/get.dart';
import 'package:hico/base/base_binding.dart';
import 'package:hico/modules/config/controllers/config_controller.dart';
import 'package:hico/modules/support/controllers/support_controller.dart';

class SupportBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<SupportController>(() => SupportController());
  }
}
