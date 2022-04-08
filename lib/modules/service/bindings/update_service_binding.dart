import 'package:get/get.dart';
import '../../../base/base_binding.dart';
import '../controllers/update_service_controller.dart';

class UpdateServiceBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<UpdateServiceController>(() => UpdateServiceController());
  }
}
