import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/home/service_category_model.dart';
import 'package:ui_api/models/home/services_model.dart';
import 'package:ui_api/models/user/user_services_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/widget_hico/service/service.dart';
import '../../../shared/widgets/showbottom_sheet/show_bottom_sheet.dart';

class CategoryServiceController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  final serviceCategories = RxList<ServiceCategoryModel>();

  //list service of user
  List<int> lstServiceId = [];
  //get data from server
  List<ServiceModel> lstService = <ServiceModel>[];
  //new data
  UserServicesCategoryModel userServicesCategory = UserServicesCategoryModel();
  RxList<ServiceModel> lstServiceChoose = RxList<ServiceModel>();

  CategoryServiceController() {
    lstServiceId = Get.arguments;
    _loadData('');
  }

  @override
  Future<void> onInit() {
    return super.onInit();
  }

  Future<void> _loadData(String keyword) async {
    try {
      await EasyLoading.show();
      await _uiRepository.serviceCategories(100, 0, keyword).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.dataServiceCategories != null &&
            response.dataServiceCategories!.serviceCategories != null) {
          serviceCategories.value =
              response.dataServiceCategories!.serviceCategories!;
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> getService(
      BuildContext context, int categoryId, String name) async {
    try {
      await EasyLoading.show();
      await _uiRepository.serviceList(20, 0, categoryId, '').then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.dataService != null) {
          lstService = response.dataService!.services!;
          return;
        }
      });
      await ShowBottomSheet().showBottomSheet(
        child: Container(
          height: Get.height / 2,
          child: ServiceWidget(
            services: lstService,
            servicesSelected: lstServiceId,
          ),
        ),
        context: context,
        onValue: (_value) {
          if (_value != null && _value is List<ServiceModel>) {
            if (_value.isNotEmpty) {
              final lstServiceTmp = <UserServicesModel>[];
              for (final item in _value) {
                if (!lstServiceId.contains(item.id)) {
                  final service_tmp = UserServicesModel();
                  service_tmp.id = item.id;
                  service_tmp.name = item.name;
                  service_tmp.isOnline = 1;
                  service_tmp.isOffline = 1;
                  lstServiceTmp.add(service_tmp);
                }
              }
              userServicesCategory.serviceCategoryId = categoryId;
              userServicesCategory.name = name;
              userServicesCategory.list = lstServiceTmp;
            }
            Get.back(result: userServicesCategory);
          }
        },
      );
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
