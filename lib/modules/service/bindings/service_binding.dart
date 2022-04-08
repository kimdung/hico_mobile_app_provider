import 'package:get/get.dart';
import 'package:hico/base/base_binding.dart';
import 'package:hico/modules/service/controllers/service_controller.dart';

class ServiceBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ServiceController>(() => ServiceController());
  }
}
