import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/master_data/districts_model.dart';
import 'package:ui_api/models/master_data/provinces_model.dart';
import 'package:ui_api/models/user/workplaces_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/widget_hico/service/service_district.dart';
import '../../../shared/widgets/showbottom_sheet/show_bottom_sheet.dart';

class AddressServiceController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  List<ProvincesModel>? lstProvincesModel = <ProvincesModel>[];
  List<DistrictsModel> lstDistrict = [];
  Rx<int> provinced = Rx(0);
  WorkplacesModel workplaces = WorkplacesModel();
  List<int> lstDistrictId = [];

  AddressServiceController() {
    lstDistrictId = Get.arguments;
    _loadData('');
  }


  Future<void> _loadData(String keyword) async {
    try {
      lstProvincesModel = AppDataGlobal.masterData!.provinces!;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> getDistricts(BuildContext context, int id, String name) async {
    try {
      provinced.value = id;
      await _uiRepository.getDistrict(id).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.districts != null) {
          lstDistrict = response.districts!;
          return;
        }
      });
      await ShowBottomSheet().showBottomSheet(
        child: Container(
          height: Get.height / 2,
          child: DistrictServiceWidget(
            districts: lstDistrict,
            districtSelected: lstDistrictId,
          ),
        ),
        context: context,
        onValue: (_value) {
          if (_value != null && _value is List<DistrictsModel>) {
            if (_value.isNotEmpty) {
              final lstDistrictTmp = <DistrictsWorkplacesModel>[];
              for (final item in _value) {
                final district_tmp = DistrictsWorkplacesModel();
                district_tmp.id = item.id;
                district_tmp.name = item.name;
                lstDistrictTmp.add(district_tmp);
              }
              workplaces.provinceId = id;
              workplaces.name = name;
              workplaces.districts = lstDistrictTmp;
            }
            Get.back(result: workplaces);
          }
        },
      );
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
