import 'package:get/get.dart';

import '../../../base/base_binding.dart';
import '../controllers/address_service_controller.dart';

class AddressServiceBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<AddressServiceController>(() => AddressServiceController());
  }
}
