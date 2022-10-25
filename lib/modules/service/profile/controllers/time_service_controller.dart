import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
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

class MarkedModel {
  EventList<Event>? dates;
  MarkedModel({this.dates});
}

class TimeServiceController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  ScrollController scrollController = ScrollController();

  List<DateTime> lstDateSelected = <DateTime>[];

  RxList<UserTimeModel> lstUserTimes = RxList<UserTimeModel>();
  List<int> lstDistrictId = [];
  RxList<UserTimeListModel> lstTimes = RxList<UserTimeListModel>();

  Rx<DateTime> currentDate = Rx(DateTime.now());
  List<int> removeTimeIds = [];

  Rx<MarkedModel> markedDate = Rx(MarkedModel());

  TimeServiceController() {
    removeTimeIds = Get.arguments;
    // prepareData();
    markedDate.value.dates = EventList<Event>(
      events: {
        DateTime.now(): [
          Event(
            date: DateTime.now(),
            title: DateTime.now().day.toString(),
          ),
        ],
      },
    );
    markedDate.refresh();
  }

  Future<void> prepareData() async {
    try {} catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> addItem(int index) async {
    try {
      final time = UserTimeListModel();
      time.beginTime = '00:00';
      time.endTime = '00:00';
      time.checkOffline = 0;
      lstUserTimes[index].list?.add(time);
      lstUserTimes.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> removeItem(int parentIndex, int index) async {
    try {
      lstUserTimes[parentIndex].list?.removeAt(index);
      if (lstUserTimes[parentIndex].list == null ||
          lstUserTimes[parentIndex].list!.isEmpty) {
        //remove calendar
        final date = DateFormatter.formatToDate(
            lstUserTimes[parentIndex].date.toString());
        final index = lstDateSelected.indexWhere((element) => element == date);
        lstDateSelected.removeAt(index);
        markedDate.value.dates?.remove(
          date,
          Event(
            date: date,
            title: date.day.toString(),
          ),
        );
        markedDate.refresh();

        lstUserTimes.removeAt(parentIndex);
      }
      lstUserTimes.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> selectDate(DateTime date) async {
    try {
      if (date.isBefore(DateTime.now().add(const Duration(days: -1)))) {
        await DialogUtil.showPopup(
          dialogSize: DialogSize.Popup,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          child: NormalWidget(
            icon: IconConstants.icFail,
            title: 'service.update.day_incorrect'.tr,
          ),
          onVaLue: (value) {
            return;
          },
        );
      } else {
        currentDate.value = date;
        if (lstDateSelected.contains(date)) {
          //remove calendar
          final index =
              lstDateSelected.indexWhere((element) => element == date);
          lstDateSelected.removeAt(index);
          markedDate.value.dates?.remove(
            date,
            Event(
              date: date,
              title: date.day.toString(),
            ),
          );
          //remove data
          final indexData = lstUserTimes.indexWhere((element) =>
              element.date == DateFormatter.formatDate(currentDate.value));
          lstUserTimes.removeAt(indexData);
        } else {
          lstDateSelected.add(date);
          markedDate.value.dates?.add(
            date,
            Event(
              date: date,
              title: date.day.toString(),
            ),
          );

          final item = UserTimeModel();
          item.date = DateFormatter.formatDate(date);
          item.list = <UserTimeListModel>[];
          final time = UserTimeListModel();
          time.beginTime = '00:00';
          time.endTime = '00:00';
          time.checkOffline = 0;
          item.list!.add(time);
          lstUserTimes.add(item);
        }
        markedDate.refresh();
      }
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> showTimeFrom(
      BuildContext context, int parentIndex, int index) async {
    final item = lstUserTimes[parentIndex].list?[index];

    await DialogUtil.showPopup(
      dialogSize: DialogSize.Popup,
      barrierDismissible: false,
      height: 300,
      backgroundColor: AppColor.primaryBackgroundColorLight,
      child: const TimeSpinerWidget(),
      onVaLue: (_value) {
        if (_value != null && _value is DateTime) {
          item?.beginTime = DateFormatter.formatTime(_value);
          lstUserTimes[parentIndex].list?[index] = item!;
          lstUserTimes.refresh();
        }
      },
    );
  }

  Future<void> showTimeTo(
      BuildContext context, int parentIndex, int index) async {
    final item = lstUserTimes[parentIndex].list?[index];

    await DialogUtil.showPopup(
      dialogSize: DialogSize.Popup,
      barrierDismissible: false,
      height: 300,
      backgroundColor: AppColor.primaryBackgroundColorLight,
      child: const TimeSpinerWidget(),
      onVaLue: (_value) {
        if (_value != null && _value is DateTime) {
          item?.endTime = DateFormatter.formatTime(_value);
          lstUserTimes[parentIndex].list?[index] = item!;
          lstUserTimes.refresh();
        }
      },
    );
  }

  Future<void> selectRadio(int value, int parentIndex, int index) async {
    final item = lstUserTimes[parentIndex].list?[index];
    item?.checkOffline = value;
    lstUserTimes[parentIndex].list?[index] = item!;
    lstUserTimes.refresh();
  }

  Future<void> comfirm() async {
    try {
      await EasyLoading.show();
      //prepare data
      final lstTimeSlotRequest = <TimeSlotModel>[];

      for (final item in lstUserTimes) {
        final timeArray = <String>[];
        for (final subItem in item.list!) {
          timeArray.add('${subItem.beginTime} - ${subItem.endTime}');
        }

        final newTime = TimeSlotModel();
        newTime.date = item.date;
        newTime.timeSlot = timeArray;
        lstTimeSlotRequest.add(newTime);
      }

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
          Get.back(result: lstUserTimes);
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
