import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/notifications/notification_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../shared/constants/common.dart';

class NotificationDetailController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  var notification = Rx(NotificationModel());

  @override
  Future<void> onInit() {
    int? id = Get.arguments;
    _loadData(id);
    return super.onInit();
  }

  Future<void> _loadData(int? id) async {
    try {
      await EasyLoading.show();
      await _uiRepository.notificationDetail(id!).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.detail != null) {
          notification.value = response.detail!.detail!;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
