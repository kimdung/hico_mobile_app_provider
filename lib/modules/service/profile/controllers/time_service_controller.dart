import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/user/user_time_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/service/update_service_request.dart';

import '../../../../base/base_controller.dart';
import '../../../../resource/assets_constant/icon_constants.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/utils/date_formatter.dart';
import '../../../../shared/utils/dialog_util.dart';
import '../../../../shared/widget_hico/dialog/normal_widget.dart';
import '../../../../shared/widget_hico/dialog/time_spiner_widget.dart';

class TimeServiceController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();

  UserTimeModel userTime = UserTimeModel();
  List<int> lstDistrictId = [];
  RxList<UserTimeListModel> lstTimes = RxList<UserTimeListModel>();

  Rx<DateTime> currentDate = Rx(DateTime.now());
  List<int> removeTimeIds = [];

  TimeServiceController() {
    removeTimeIds = Get.arguments;
    prepareData();
  }

  Future<void> prepareData() async {
    try {
      userTime.date = DateFormatter.formatDate(currentDate.value);
      final time = UserTimeListModel();
      time.beginTime = '0:00';
      time.endTime = '0:00';
      time.checkOffline = 0;
      lstTimes.add(time);
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> addItem() async {
    try {
      final time = UserTimeListModel();
      time.beginTime = '0:00';
      time.endTime = '0:00';
      time.checkOffline = 0;
      lstTimes.add(time);
      lstTimes.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> selectDate(DateTime date) async {
    try {
      currentDate.value = date;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> showTimeFrom(BuildContext context, int index) async {
    final item = lstTimes[index];

    await DialogUtil.showPopup(
      dialogSize: DialogSize.Popup,
      barrierDismissible: true,
      height: 300,
      backgroundColor: AppColor.primaryBackgroundColorLight,
      child: const TimeSpinerWidget(),
      onVaLue: (_value) {
        if (_value != null && _value is DateTime) {
          item.beginTime = DateFormatter.formatTime(_value);
          lstTimes[index] = item;
          lstTimes.refresh();
        }
      },
    );

    // await DatePicker.showTimePicker(
    //   context,
    //   showTitleActions: true,
    //   showSecondsColumn: false,
    //   onConfirm: (date) {
    //     item.beginTime = DateFormatter.formatTime(date);
    //     lstTimes[index] = item;
    //     lstTimes.refresh();
    //   },
    //   currentTime: DateTime.now(),
    // );
  }

  Future<void> showTimeTo(BuildContext context, int index) async {
    final item = lstTimes[index];

    await DialogUtil.showPopup(
      dialogSize: DialogSize.Popup,
      barrierDismissible: true,
      height: 300,
      backgroundColor: AppColor.primaryBackgroundColorLight,
      child: const TimeSpinerWidget(),
      onVaLue: (_value) {
        if (_value != null && _value is DateTime) {
          item.endTime = DateFormatter.formatTime(_value);
          lstTimes[index] = item;
          lstTimes.refresh();
        }
      },
    );

    // await DatePicker.showTimePicker(
    //   context,
    //   showTitleActions: true,
    //   showSecondsColumn: false,
    //   onConfirm: (date) {
    //     item.endTime = DateFormatter.formatTime(date);
    //     lstTimes[index] = item;
    //     lstTimes.refresh();
    //   },
    //   currentTime: DateTime.now(),
    // );
  }

  Future<void> selectRadio(int value, int index) async {
    final item = lstTimes[index];
    item.checkOffline = value;
    lstTimes[index] = item;
    lstTimes.refresh();
  }

  Future<void> removeItem(int index) async {
    try {
      lstTimes.removeAt(index);
      lstTimes.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> comfirm() async {
    try {
      userTime.date = DateFormatter.formatDate(currentDate.value);
      userTime.list = lstTimes;
      //prepare data
      final timeArray = <String>[];
      for (final item in userTime.list!) {
        timeArray.add('${item.beginTime} - ${item.endTime}');
      }
      final lstTimeSlotRequest = <TimeSlotModel>[];
      final newTime = TimeSlotModel();
      newTime.date = userTime.date;
      newTime.timeSlot = timeArray;
      lstTimeSlotRequest.add(newTime);

      //call api check time
      await _uiRepository
          .checkUserTime(
        UpdateServiceRequest(
          userTime: lstTimeSlotRequest,
          removeTimeIds: removeTimeIds,
        ),
      )
          .then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk) {
          Get.back(result: userTime);
        } else {
          DialogUtil.showPopup(
            dialogSize: DialogSize.Popup,
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            child: NormalWidget(
              icon: IconConstants.icFail,
              title: response.message,
            ),
            onVaLue: (value) {},
          );
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
