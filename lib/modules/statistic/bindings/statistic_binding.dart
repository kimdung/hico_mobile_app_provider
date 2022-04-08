import 'package:get/get.dart';
import 'package:hico/base/base_binding.dart';
import 'package:hico/modules/statistic/controllers/statistic_controller.dart';

class StatisticBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<StatisticController>(() => StatisticController());
  }
}
