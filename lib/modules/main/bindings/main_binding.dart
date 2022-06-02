import 'package:get/get.dart';
import '../../../base/base_binding.dart';
import '../controllers/main_controller.dart';

class MainBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<MainController>(() => MainController());
  }
}
