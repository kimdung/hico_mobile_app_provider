import 'package:get/get.dart';
import 'package:hico/base/base_binding.dart';
import 'package:hico/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
