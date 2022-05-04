import 'package:get/get.dart';
import 'package:ui_api/models/wallet/topup_history_model.dart';

import '../../../../base/base_controller.dart';

class TopupDetailController extends BaseController {
  TopupHistoryModel? topup;

  TopupDetailController(this.topup);

  @override
  Future<void> onInit() async {
    await super.onInit();
  }

  /* Action */

  void onTopup() {
    Get.back(result: true);
  }
}
