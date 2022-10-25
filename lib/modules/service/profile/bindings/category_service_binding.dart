import 'package:get/get.dart';

import '../../../../base/base_binding.dart';
import '../controllers/category_service_controller.dart';

class CategoryServiceBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CategoryServiceController>(() => CategoryServiceController());
  }
}
