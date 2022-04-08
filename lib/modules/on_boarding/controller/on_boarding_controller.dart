import 'package:get/get.dart';
import '../../../base/base_controller.dart';
import '../../../resource/assets_constant/images_constants.dart';

import '../../../routes/app_pages.dart';

class OnBoardingController extends BaseController {
  @override
  Future<void> onReady() async {
    super.onReady();
  }

  final lstSlider = [
    SliderModel(
        title: 'onboard.title1'.tr,
        image: 'lib/resource/assets_resources/images/slider.png',
        description: 'onboard.description1'.tr),
    SliderModel(
        title: 'onboard.title2'.tr,
        image: 'lib/resource/assets_resources/images/slider2.png',
        description: 'onboard.description2'.tr),
    SliderModel(
        title: 'onboard.title3'.tr,
        image: 'lib/resource/assets_resources/images/slider3.png',
        description: 'onboard.description3'.tr),
  ];

  final Rx<int> sliderCurrentIndex = Rx(0);
  final RxList<String> promotions =
      RxList.generate(3, (index) => ImageConstants.sliderDemo);

  Future<void> login() async {
    await Get.toNamed(Routes.LOGIN);
  }

  Future<void> signup() async {
    await Get.toNamed(Routes.REGISTER);
  }
}

class SliderModel {
  String? image;
  String? title;
  String? description;

  SliderModel({
    this.image,
    this.title,
    this.description,
  });
}
