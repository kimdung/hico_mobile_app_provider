import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:ui_api/models/call/call_model.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/call_utilities.dart';

class ChatController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();

  late Channel channel;
  late User user;
  late bool isNotCall;
  
  @override
  Future<void> onInit() async {
    final arguments = Get.arguments as Map;
    channel = arguments[CommonConstants.CHANNEL];
    user = arguments[CommonConstants.CHAT_USER];
    isNotCall = arguments[CommonConstants.IS_NOT_CALL] ?? false;
    await channel.watch();

    final addMembers = [user.id];
    if (AppDataGlobal.userInfo?.id != null) {
      addMembers.add(AppDataGlobal.userInfo!.id!.toString());
    }
    await channel.addMembers(addMembers);

    await super.onInit();
  }

  Future<void> onCall() async {
    final channelId = channel.id;
    if (channelId == null) {
      return;
    }
    try {
      await EasyLoading.show();
      await _uiRepository.getCallToken(channelId).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          final call = CallModel(
            callerId: AppDataGlobal.userInfo?.id,
            callerName: AppDataGlobal.userInfo?.name ?? '',
            callerPic: AppDataGlobal.userInfo?.avatarImage ?? '',
            receiverId: int.tryParse(user.id),
            receiverName: user.name,
            receiverPic: user.image ?? '',
            channelId: channelId,
            hasDialled: true,
            isVideo: false,
          );
          CallUtils.dial(callMethods, call, response.data?.token ?? '');
        } else if (response.message?.isNotEmpty ?? false) {
          EasyLoading.showToast(response.message ?? '');
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onVideo() async {
    final channelId = channel.id;
    if (channelId == null) {
      return;
    }
    try {
      await EasyLoading.show();
      await _uiRepository.getCallToken(channelId).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          final call = CallModel(
            callerId: AppDataGlobal.userInfo?.id,
            callerName: AppDataGlobal.userInfo?.name ?? '',
            callerPic: AppDataGlobal.userInfo?.avatarImage ?? '',
            receiverId: int.tryParse(user.id),
            receiverName: user.name,
            receiverPic: user.image ?? '',
            channelId: channelId,
            hasDialled: true,
            isVideo: true,
          );
          CallUtils.dial(callMethods, call, response.data?.token ?? '');
        } else if (response.message?.isNotEmpty ?? false) {
          EasyLoading.showToast(response.message ?? '');
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
