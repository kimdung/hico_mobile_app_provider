import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final changePassForm = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newsPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String html = '''
<div>
<h3>Tình trạng thiếu thông dịch viên tiếng Việt</h3>
<p>Osaka International House Foundation cung cấp thông dịch viên cho người nước ngoài hoặc giới thiệu họ đến các văn phòng chính phủ. 
Từ khi Covid-19 bắt đầu lan rộng, tổ chức này nhận được ngày càng nhiều các yêu cầu về chăm sóc sức khỏe và việc làm từ người dân Việt Nam.</p>
<p>Có hơn 420.000 người Việt Nam cư trú tại Nhật Bản, tính đến cuối tháng 6, 
tăng 2% so với cuối năm ngoái và gấp 3,4 lần so với 5 năm trước đó, theo Bộ Tư pháp Nhật Bản. 
Họ chiếm 14,6% tổng số cư dân nước ngoài tại Nhật, tăng 8,8% so với 5 năm trước đó. 
Đây cũng là tỷ lệ cao thứ ba, sau người Trung Quốc và Hàn Quốc.
</p>
<p>Số lượng thông dịch viên tiếng Việt ít do khan hiếm người Việt thuộc thế hệ thứ hai và thứ ba thông thạo cả hai thứ tiếng. 
Nguồn tài chính công eo hẹp khiến chính quyền địa phương ngần ngại khi thuê thông dịch viên thường trực. 
Các trường hợp ngoại lệ là các địa phương có đông người nước ngoài, 
như văn phòng thị trấn Oizumi ở tỉnh Gunma và chính quyền thành phố Yao ở tỉnh Osaka.</p>
</div>
''';

  bool showPassword = false;

  @override
  Future<void> onInit() {
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

  @override
  void onClose() {}
}
