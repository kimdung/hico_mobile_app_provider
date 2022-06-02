import 'package:get/get.dart';
import '../../../base/base_binding.dart';
import '../controllers/news_detail_controller.dart';

class NewsDetailBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<NewsDetailController>(() => NewsDetailController());
  }
}
