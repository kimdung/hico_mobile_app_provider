import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../shared/constants/common.dart';

class ChatController extends BaseController {
  // final InvoiceModel invoiceModel;

  // final client = StreamChatClient('2utk87k45e87', logLevel: Level.INFO);
  late Channel channel;
  late User user;

  @override
  Future<void> onInit() async {
    final arguments = Get.arguments as Map;
    channel = arguments[CommonConstants.CHANNEL];
    user = arguments[CommonConstants.CHAT_USER];
    await channel.watch();

    final addMembers = [user.id];
    if (AppDataGlobal.userInfo?.id != null) {
      addMembers.add(AppDataGlobal.userInfo!.id!.toString());
    }
    await channel.addMembers(addMembers);

    await super.onInit();
  }
}
