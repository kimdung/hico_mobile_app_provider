import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';

class ServiceController extends BaseController {
  final Rx<int> totalRecord = Rx(0);

  List<int> listRecord = List<int>.generate(20, (i) => i + 1);

  Rx<UserInfoModel> info = Rx(UserInfoModel(
      avatarImage: '',
      documentBackSide: '',
      documentsCertificate: [],
      documentFrontSide: ''));
  final _uiRepository = Get.find<HicoUIRepository>();

  ServiceController() {
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
          info.value = response.data!.info!;
          AppDataGlobal.userInfo = response.data!.info!;
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> edit() async {
    await Get.toNamed(Routes.UPDATE_SERVICE)?.then((value) {
      _loadData();
    });
  }

  @override
  void onClose() {}
}
