import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart'; 
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../data/app_data_global.dart';
import '../../routes/app_pages.dart';
import '../constants/common.dart';

class ChatUtil {
  static Future<void> initChat(String apiKey) async {
    try {
      AppDataGlobal.client = StreamChatClient(apiKey, logLevel: Level.INFO);
      AppDataGlobal.client?.on(
        EventType.messageNew,
        EventType.notificationMessageNew,
      );

      await AppDataGlobal.client?.connectUser(
        AppDataGlobal.userInfo!.getChatUser(),
        AppDataGlobal.userInfo?.conversationInfo?.token ?? '',
      );

      await AppDataGlobal.client?.getDevices().then((listDevicesResponse) {
        var isExist = false;
        listDevicesResponse.devices.forEach((device) {
          if (device.id == AppDataGlobal.firebaseToken) {
            print('[ChatUtil] added firebaseToken ${device.id}');
            isExist = true;
          } else {
            print('[ChatUtil] removeDevice firebaseToken ${device.id}');
            AppDataGlobal.client?.removeDevice(device.id);
          }
        });
        if (!isExist) {
          print(
              '[ChatUtil] new add firebaseToken ${AppDataGlobal.firebaseToken}');
          AppDataGlobal.client
              ?.addDevice(AppDataGlobal.firebaseToken, PushProvider.firebase);
        }
      });
    } catch (e) {
      log('[ChatUtil] create chat error ${e.toString()}');
    }
  }

  static Future<void> chatAdmin(Channel adminChatChannel) async {
    try {
      if (AppDataGlobal.client == null) {
        await EasyLoading.showToast('error.not.connect'.tr);
        return;
      }

      await EasyLoading.show();
      final _usersResponse = await AppDataGlobal.client?.queryUsers(
        filter: Filter.autoComplete(
            'id', AppDataGlobal.userInfo?.conversationInfo?.adminId ?? ''),
      );
      await EasyLoading.dismiss();
      await Get.toNamed(Routes.CHAT, arguments: {
        CommonConstants.CHANNEL: adminChatChannel,
        CommonConstants.CHAT_USER: (_usersResponse?.users.isEmpty ?? true)
            ? AppDataGlobal.userInfo?.conversationInfo?.getAdmin()
            : _usersResponse!.users.first,
        CommonConstants.IS_NOT_CALL: true,
      });
    } catch (e) {
      log('[ChatUtil] chat error ${e.toString()}');
      await EasyLoading.showToast('error.not.connect'.tr);
    }
  }
}
