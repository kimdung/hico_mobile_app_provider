import 'package:get/get.dart';

import '../../../base/base_binding.dart';
import '../controllers/rating_controller.dart';

class RatingtBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<RatingController>(() => RatingController());
  }
}
