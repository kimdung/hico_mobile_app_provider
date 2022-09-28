import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/response/rating/rating_response.dart';

import '../../../base/base_controller.dart';
import '../../../shared/constants/common.dart';

class RatingController extends BaseController {
  bool showPassword = false;
  final _uiRepository = Get.find<HicoUIRepository>();

  Rx<int> total = Rx(0);
  Rx<int> currentStar = Rx(0);
  int limit = 4;
  int offset = 0;
  Rx<RatingInfoModel> ratingInfo = Rx(RatingInfoModel());

  RatingController() {
    loadData();
  }

  Future<void> loadData() async {
    try {
      offset = 0;
      await EasyLoading.show();
      await _uiRepository
          .listReview(currentStar.value, limit, offset)
          .then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          offset = response.data!.rows!.length;
          ratingInfo.value = response.data!;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> selectStar(int star) async {
    await EasyLoading.show();
    currentStar.value = star;
    await loadData();
  }

  @override
  void onClose() {}
}
