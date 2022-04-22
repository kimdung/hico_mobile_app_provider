import 'package:get/get.dart';

import '../controller/medical_controller.dart';

class MedicalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicalController());
  }
}
