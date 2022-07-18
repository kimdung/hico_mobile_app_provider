import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_api/models/master_data/master_data_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../resource/lang/translation_service.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/constants/storage.dart';
import '../../../shared/styles/text_style/text_style.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widgets/image_widget/fcore_image.dart';

enum LanguageCode { VN, EN, JA }

extension LanguageValue on LanguageCode {
  Locale get languageLocale {
    switch (this) {
      case LanguageCode.VN:
        return const Locale('vi', 'VN');
      case LanguageCode.EN:
        return const Locale('en', 'US');
      case LanguageCode.JA:
        return const Locale('ja', 'JP');
      default:
        return const Locale('vi', 'VN');
    }
  }
}

class ConfigController extends BaseController {
  Rx<LanguageCode> currentLanguage = Rx<LanguageCode>(LanguageCode.VN);
  final storage = Get.find<SharedPreferences>();
  final HicoUIRepository _uiRepository = Get.find<HicoUIRepository>();

  final changePassForm = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newsPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String html = '';

  bool showPassword = false;
  MasterDataModel masterData = MasterDataModel();

  @override
  Future<void> onInit() {
    masterData = AppDataGlobal.masterData!;
    final language = storage.getString(StorageConstants.language);
    switch (language) {
      case VIETNAMESE_LANG:
        currentLanguage.value = LanguageCode.VN;
        break;
      case ENGLISH_LANG:
        currentLanguage.value = LanguageCode.EN;
        break;
      case JAPANESE_LANG:
        currentLanguage.value = LanguageCode.JA;
        break;
    }
    return super.onInit();
  }

  Future<void> selectLanguage() async {
    switch (currentLanguage.value) {
      case LanguageCode.VN:
        AppDataGlobal.languageCode = VIETNAMESE_LANG;
        break;
      case LanguageCode.EN:
        AppDataGlobal.languageCode = ENGLISH_LANG;
        break;
      case LanguageCode.JA:
        AppDataGlobal.languageCode = JAPANESE_LANG;
        break;
    }

    TranslationService.changeLocale(currentLanguage.value.languageLocale);

    await storage.setString(
        StorageConstants.language, AppDataGlobal.languageCode);

    await _uiRepository.masterData().then((response) {
      if (response.status == CommonConstants.statusOk &&
          response.masterDataModel != null) {
        AppDataGlobal.masterData = response.masterDataModel!;
        return;
      }
    });
  }


  Future<void> confirmLanguage() async {
    switch (currentLanguage.value) {
      case LanguageCode.VN:
        AppDataGlobal.languageCode = VIETNAMESE_LANG;
        break;
      case LanguageCode.EN:
        AppDataGlobal.languageCode = ENGLISH_LANG;
        break;
      case LanguageCode.JA:
        AppDataGlobal.languageCode = JAPANESE_LANG;
        break;
    }

    TranslationService.changeLocale(currentLanguage.value.languageLocale);

    await storage.setString(
        StorageConstants.language, AppDataGlobal.languageCode);
    Get.back();
  }

  Future<void> changePassword() async {
    if (changePassForm.currentState?.validate() ?? false) {
      oldPasswordController.clear();
      newsPasswordController.clear();
      confirmPasswordController.clear();
      await DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: true,
        height: 158,
        backgroundColor: AppColor.primaryBackgroundColorLight.withOpacity(0.9),
        child: Column(
          children: [
            const SizedBox(height: 19),
            FCoreImage(IconConstants.icPassSuccess),
            const SizedBox(height: 15),
            Text(
              'Thay đổi mật khẩu',
              style: TextAppStyle().genaralTextStyle().copyWith(
                    color: Colors.black,
                  ),
            ),
            Text('Thành công',
                style: TextAppStyle().genaralTextStyle().copyWith(
                      color: AppColor.primaryTextColorLight,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
          ],
        ),
      );
    }
  }

  Future<void> makeAction(String scheme, String endpoint) async {
    final launchUri = Uri(
      scheme: scheme,
      path: endpoint,
    );
    await launchUrl(launchUri);
  }

  @override
  void onClose() {}
}
