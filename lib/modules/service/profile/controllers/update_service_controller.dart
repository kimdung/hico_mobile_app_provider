import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/user/user_services_model.dart';
import 'package:ui_api/models/user/user_time_model.dart';
import 'package:ui_api/models/user/workplaces_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/service/update_service_request.dart';

import '../../../../base/base_controller.dart';
import '../../../../data/app_data_global.dart';
import '../../../../resource/assets_constant/icon_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/utils/dialog_util.dart';
import '../../../../shared/widget_hico/dialog/normal_widget.dart';

class UpdateServiceController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();

  //old data
  RxList<UserServicesCategoryModel> lstServiceUser =
      RxList<UserServicesCategoryModel>();
  RxList<WorkplacesModel> lstWorkplaces = RxList<WorkplacesModel>();
  RxList<UserTimeModel> lstUserTimes = RxList<UserTimeModel>();

  //data change
  UserServicesCategoryModel servicesReturn = UserServicesCategoryModel();
  WorkplacesModel workplacesReturn = WorkplacesModel();
  //UserTimeModel userTime = UserTimeModel();
  List<UserTimeModel> lstUserTimeReturn = <UserTimeModel>[];

  //data request
  List<int> lstDistrictId = [];
  List<int> removeTimeIds = [];
  List<int> lstSevicedId = [];
  List<TimeSlotModel> lstTimeSlotRequest = [];

  UpdateServiceController() {
    _loadData();
  }

  Future _loadData() async {
    try {
      await EasyLoading.show();
      await _uiRepository.getInfo().then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.info != null) {
          lstServiceUser.value = response.data!.info!.services!;
          lstWorkplaces.value = response.data!.info!.workplaces!;
          lstUserTimes.value = response.data!.info!.userTime!;
          prepareData();
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future prepareData() async {
    try {
      //service
      for (final item in lstServiceUser) {
        lstSevicedId.addAll(item.list!.map((e) => e.id!).toList());
      }
      //district id
      if (lstWorkplaces.isNotEmpty) {
        for (final provinces in lstWorkplaces) {
          if (provinces.districts != null && provinces.districts!.isNotEmpty) {
            for (final district in provinces.districts!) {
              lstDistrictId.add(district.id!);
            }
          }
        }
      }
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future addService() async {
    try {
      await Get.toNamed(Routes.CATEGORY_SERVICE, arguments: lstSevicedId)
          ?.then((value) {
        if (value != null) {
          servicesReturn = value;
          if (servicesReturn.serviceCategoryId != null) {
            if (lstServiceUser
                .where((elm) =>
                    elm.serviceCategoryId == servicesReturn.serviceCategoryId)
                .isNotEmpty) {
              final categoryIndex = lstServiceUser.indexWhere((x) =>
                  x.serviceCategoryId == servicesReturn.serviceCategoryId);
              for (final item in servicesReturn.list!) {
                if (!lstSevicedId.contains(item.id)) {
                  lstServiceUser[categoryIndex].list!.add(item);
                  lstSevicedId.add(item.id!);
                }
              }
            } else {
              lstServiceUser.add(servicesReturn);
              lstSevicedId.addAll(servicesReturn.list!.map((e) => e.id!));
            }
          }

          lstServiceUser.refresh();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future addWorkplaces() async {
    try {
      await Get.toNamed(Routes.ADDRESS_SERVICE, arguments: lstDistrictId)
          ?.then((value) {
        if (value != null) {
          workplacesReturn = value;
          if (workplacesReturn.provinceId != null) {
            if (lstWorkplaces
                .where((elm) => elm.provinceId == workplacesReturn.provinceId)
                .isNotEmpty) {
              final provinceIndex = lstWorkplaces.indexWhere(
                  (x) => x.provinceId == workplacesReturn.provinceId);
              for (final item in workplacesReturn.districts!) {
                if (!lstDistrictId.contains(item.id)) {
                  lstWorkplaces[provinceIndex].districts!.add(item);
                  lstDistrictId.add(item.id!);
                }
              }
            } else {
              lstWorkplaces.add(workplacesReturn);
              lstDistrictId
                  .addAll(workplacesReturn.districts!.map((e) => e.id!));
            }
            lstWorkplaces.refresh();
          }
        }
      });
      print(lstDistrictId);
    } catch (e) {
      print(e);
    }
  }

  Future addUserTime() async {
    try {
      await Get.toNamed(Routes.TIME_SERVICE, arguments: removeTimeIds)
          ?.then((value) {
        if (value != null) {
          lstUserTimeReturn = value;
          for (var userTime in lstUserTimeReturn) {
            if (userTime.list != null && userTime.list!.isNotEmpty) {
              //update data view
              //check list view
              if (lstUserTimes
                  .where((element) => element.date == userTime.date)
                  .isEmpty) {
                lstUserTimes.add(userTime);
              } else {
                final indexItem =
                    lstUserTimes.indexWhere((e) => e.date == userTime.date);
                lstUserTimes[indexItem].list!.addAll(userTime.list!);
              }
              lstUserTimes.refresh();

              //prepare data
              final offlineArray = <int>[];
              for (final item in userTime.list!) {
                offlineArray.add(item.checkOffline ?? 0);
              }
              final timeArray = <String>[];
              for (final item in userTime.list!) {
                timeArray.add('${item.beginTime} - ${item.endTime}');
              }
              //check list request
              if (lstTimeSlotRequest
                  .where((element) => element.date == userTime.date)
                  .isEmpty) {
                final newTime = TimeSlotModel();
                newTime.date = userTime.date;
                newTime.checkOffline = offlineArray;
                newTime.timeSlot = timeArray;
                lstTimeSlotRequest.add(newTime);
              } else {
                final indexItem = lstTimeSlotRequest
                    .indexWhere((e) => e.date == userTime.date);
                lstTimeSlotRequest[indexItem]
                    .checkOffline!
                    .addAll(offlineArray);
                lstTimeSlotRequest[indexItem].timeSlot!.addAll(timeArray);
              }
            }
          }
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future changeWorkingForm(
      {required int serviceCategoryId,
      required int serviceId,
      required int type,
      required int value}) async {
    try {
      //get category in list
      final serviceCategory = lstServiceUser.firstWhere(
          (element) => element.serviceCategoryId == serviceCategoryId,
          orElse: () => UserServicesCategoryModel());
      //get service model in category
      final service = serviceCategory.list!.firstWhere((e) => e.id == serviceId,
          orElse: () => UserServicesModel());
      //set value
      if (type == CommonConstants.online) {
        service.isOnline = value;
      } else {
        service.isOffline = value;
      }
      //get index
      final categoryIndex = lstServiceUser.indexWhere(
          (element) => element.serviceCategoryId == serviceCategoryId);

      final serviceIndex = lstServiceUser[categoryIndex]
          .list!
          .indexWhere((e) => e.id == serviceId);

      //update model
      lstServiceUser[categoryIndex].list![serviceIndex] = service;
      lstServiceUser.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future removeService({
    required int serviceCategoryId,
    required int serviceId,
  }) async {
    try {
      final categoryIndex = lstServiceUser.indexWhere(
          (element) => element.serviceCategoryId == serviceCategoryId);
      lstServiceUser[categoryIndex]
          .list!
          .removeWhere((element) => element.id == serviceId);
      lstSevicedId.removeWhere((element) => element == serviceId);
      lstServiceUser.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future removeDistrict(int provinceId, int id) async {
    try {
      //district id
      lstDistrictId.removeWhere((e) => e == id);

      final provinceIndex =
          lstWorkplaces.indexWhere((e) => e.provinceId == provinceId);
      lstWorkplaces[provinceIndex].districts?.removeWhere((e) => e.id == id);
      if (lstWorkplaces[provinceIndex].districts!.isEmpty) {
        lstWorkplaces
            .removeWhere((element) => element.provinceId == provinceId);
      }
      lstWorkplaces.refresh();
      print(lstDistrictId);
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future removeTime(int index) async {
    try {
      final userTimeTmp = lstUserTimes[index];

      //remove data request
      final lstId = lstUserTimes[index]
          .list!
          .where((element) => element.id != null)
          .map((e) => e.id!)
          .toList();
      removeTimeIds.addAll(lstId);
      if (lstTimeSlotRequest.isNotEmpty) {
        final indexItem = lstTimeSlotRequest
            .indexWhere((element) => element.date == userTimeTmp.date);
        lstTimeSlotRequest.removeAt(indexItem);
      }

      //remove data view
      lstUserTimes.removeAt(index);
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future save() async {
    try {
      await EasyLoading.show();
      //prepare
      final lstServiceRequest = <UserServicesModel>[];
      for (final item in lstServiceUser) {
        lstServiceRequest.addAll(item.list!);
      }
      log('data: ${lstTimeSlotRequest.toString()}');
      //call api
      await _uiRepository
          .updateService(UpdateServiceRequest(
        services: lstServiceRequest,
        districtIds: lstDistrictId,
        userTime: lstTimeSlotRequest,
        removeTimeIds: removeTimeIds,
      ))
          .then((response) {
        EasyLoading.dismiss();
        DialogUtil.showPopup(
          dialogSize: DialogSize.Popup,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          child: NormalWidget(
            icon: response.status == CommonConstants.statusOk
                ? IconConstants.icSuccess
                : IconConstants.icFail,
            title: response.message,
          ),
          onVaLue: (value) {
            if (response.status == CommonConstants.statusOk) {
              if (AppDataGlobal.userInfo!.kycStatus == 1) {
                Get.back();
              } else {
                Get.offAllNamed(Routes.UPDATE_SERVICE_SUCCESS);
              }
            }
          },
        );
        return;
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> changeArrow(WorkplacesModel item) async {
    try {
      item.openChild = !item.openChild!;
      var index = lstWorkplaces
          .indexWhere((element) => element.provinceId == item.provinceId);
      if (index != -1) {
        lstWorkplaces[index] = item;
        lstWorkplaces.refresh();
      }
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
