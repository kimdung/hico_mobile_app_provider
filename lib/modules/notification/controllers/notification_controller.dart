import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/notifications/notification_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/invoice/booking_extend_request.dart';

import '../../../base/base_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';
import '../../main/controllers/main_controller.dart';

class NotificationController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  late MainController mainController;

  ScrollController scrollController = ScrollController();
  RxList<NotificationModel> notificationList = RxList<NotificationModel>();
  int limit = CommonConstants.limit;
  int offset = 0;

  NotificationController(this.mainController) {
    //loadData();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          debugPrint('reload');
        } else {
          _loadMore();
        }
      }
    });
  }

  Future<void> loadData() async {
    try {
      await EasyLoading.show();
      await mainController.countNotifyUnread();
      offset = 0;
      await _uiRepository.notificationList(limit, offset).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.rows != null) {
          if (response.data!.rows!.isNotEmpty) {
            offset = response.data!.rows!.length;
            notificationList.value = response.data!.rows!;
          }
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> _loadMore() async {
    try {
      await EasyLoading.show();
      await _uiRepository.notificationList(limit, offset).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.rows != null) {
          if (response.data!.rows!.isNotEmpty) {
            offset += response.data!.rows!.length;
            notificationList.addAll(response.data!.rows!);
          }
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> viewDetail(
      int id, int displayType, int? invoiceId, int? subId) async {
    if (displayType == DisplayType.Notif.id) {
      await Get.toNamed(Routes.NOTIFICATION_DETAIL, arguments: id)
          ?.then((value) => loadData());
    } else if (displayType == 7) {
      await _uiRepository.notificationDetail(id).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.detail != null) {
          Get.toNamed(Routes.BOOKING_DETAIL,
                  arguments:
                      BookingExtendRequest(invoiceId: invoiceId, subId: subId))
              ?.then((value) {
            loadData();
          });
        }
      });
    } else if (displayType == DisplayType.UpdateInfo.id) {
      await _uiRepository.notificationDetail(id).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.detail != null) {
          Get.toNamed(Routes.UPDATE_SERVICE)?.then((value) {
            loadData();
          });
        }
      });
    } else {
      await _uiRepository.notificationDetail(id).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.detail != null) {
          Get.toNamed(Routes.ORDER_DETAIL, arguments: invoiceId)
              ?.then((value) => loadData());
        }
      });
    }
  }

  @override
  void onClose() {}
}
