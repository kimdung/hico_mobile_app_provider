import 'package:get/get.dart';

import '../../../base/base_binding.dart';
import '../controllers/order_controller.dart';

class OrderBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<OrderController>(() => OrderController());
  }
}
