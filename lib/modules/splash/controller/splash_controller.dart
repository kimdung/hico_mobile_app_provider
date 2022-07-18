import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/login/login_request.dart';

import '../../../data/app_data_global.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/constants/storage.dart';
import '../../../shared/services/firebase_cloud_messaging.dart';
import '../../../shared/utils/chat_util.dart';

class SplashController extends GetxController {
  final HicoUIRepository _uiRepository = Get.find<HicoUIRepository>();
  final config = FirebaseMessageConfig();
  final storage = Get.find<SharedPreferences>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await config.initFirebaseMessageConfig();
    await config.handleMessage();
    await loadInitSplashScreen();
  }

  Future<void> loadInitSplashScreen() async {
    _loadTheme(storage);
    await _loadMasterData();
    _loadLanguage(storage);

    final isLogin = storage.getBool(StorageConstants.isLogin);
    final isSocial = storage.getBool(StorageConstants.isSocial);

    if (isLogin ?? false) {
      _autoLogin();
    } else if (isSocial ?? false) {
      final token = storage.getString(StorageConstants.token);
      AppDataGlobal.accessToken = token!;
      try {
        await _uiRepository.getInfo().then((response) {
          if (response.status == CommonConstants.statusOk &&
              response.data != null &&
              response.data!.info != null) {
            loadData(response.data!.info!, token);
          } else {
            Get.offAndToNamed(Routes.LANGUAGE);
          }
        });
      } catch (e) {
        await Get.offAndToNamed(Routes.LANGUAGE);
      }
    } else {
      await Get.offAndToNamed(Routes.LANGUAGE);
    }
  }

  void _autoLogin() {
    final username = storage.getString(StorageConstants.username);
    final password = storage.getString(StorageConstants.password);
    _uiRepository
        .login(LoginRequest(
            email: username,
            password: password,
            deviceIdentifier: AppDataGlobal.firebaseToken))
        .then((response) {
      if (response.status == CommonConstants.statusOk &&
          response.loginModel != null &&
          response.loginModel!.info != null) {
        loadData(
            response.loginModel!.info!, response.loginModel!.accessToken ?? '');
      } else {
        storage.setBool(StorageConstants.isLogin.toString(), false);
        _loadLanguage(storage);
         Get.offAndToNamed(Routes.LANGUAGE);
      }
    });
  }

  Future<void> loadData(UserInfoModel userInfo, String accessToken) async {
    AppDataGlobal.accessToken = accessToken;
    AppDataGlobal.userInfo = userInfo;
    AppDataGlobal.isLogin = true;

    if (userInfo.conversationInfo?.token?.isEmpty ?? true) {
      await _uiRepository.createChatToken().then((response) {
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          AppDataGlobal.userInfo?.conversationInfo = response.data;
        }
      });
    }

    await ChatUtil.initChat(
        AppDataGlobal.userInfo?.conversationInfo?.apiKey ?? '');

    await Get.offAllNamed(Routes.MAIN);
  }

  void _loadLanguage(SharedPreferences storage) {
    final language = storage.getString(StorageConstants.language);
    if (language == null) {
      AppDataGlobal.languageCode = VIETNAMESE_LANG;
      Get.updateLocale(const Locale('vi', 'VN'));
      //Get.offAndToNamed(Routes.LANGUAGE);
      return;
    } else {
      AppDataGlobal.languageCode = language;

      if (language == VIETNAMESE_LANG) {
        Get.updateLocale(const Locale('vi', 'VN'));
      }

      if (language == JAPANESE_LANG) {
        Get.updateLocale(const Locale('ja', 'JP'));
      }

      if (language == ENGLISH_LANG) {
        Get.updateLocale(const Locale('en', 'US'));
      }
      //Get.offAndToNamed(Routes.LANGUAGE);
    }
  }

  void _loadTheme(SharedPreferences storage) {
    final theme = storage.getString(StorageConstants.theme);
    if (theme == null || theme == LIGHT_THEME) {
      Get.changeThemeMode(ThemeMode.light);
      storage.setString(StorageConstants.theme, LIGHT_THEME);
      return;
    }

    Get.changeThemeMode(ThemeMode.dark);
    storage.setString(StorageConstants.theme, DARK_THEME);
  }

  Future<void> _loadMasterData() async {
    await _uiRepository.masterData().then((response) {
      if (response.status == CommonConstants.statusOk &&
          response.masterDataModel != null) {
        AppDataGlobal.masterData = response.masterDataModel!;
        return;
      }
    });
  }
}
