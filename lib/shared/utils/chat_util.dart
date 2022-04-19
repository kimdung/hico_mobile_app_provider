import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../data/app_data_global.dart';

class ChatUtil {
  static Future<void> initChat(String apiKey) async {
    AppDataGlobal.client = StreamChatClient(apiKey, logLevel: Level.INFO);
    AppDataGlobal.client?.on(
      EventType.messageNew,
      EventType.notificationMessageNew,
    );
    await AppDataGlobal.client?.connectUser(
      AppDataGlobal.userInfo!.getChatUser(),
      AppDataGlobal.userInfo?.conversationInfo?.token ?? '',
    );

    await AppDataGlobal.client
        ?.addDevice(AppDataGlobal.firebaseToken, PushProvider.firebase);
  }
}
