import 'package:get/get.dart';
import '../../../base/base_binding.dart';
import '../controllers/config_controller.dart';

class ConfigBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ConfigController>(() => ConfigController());
  }
}
