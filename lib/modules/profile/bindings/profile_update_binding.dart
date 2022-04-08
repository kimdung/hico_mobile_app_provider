import 'package:get/get.dart';
import '../../../base/base_binding.dart';
import '../controllers/profile_update_controller.dart';

class ProfileUpdateBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ProfileUpDateController>(() => ProfileUpDateController());
  }
}
