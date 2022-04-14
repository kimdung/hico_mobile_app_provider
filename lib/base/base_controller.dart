import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../data/app_data_global.dart';
import '../data/interceptors/listen_error_graphql_interceptor.dart';
import '../shared/dialog_manager/data_models/request/common_dialog_request.dart';
import '../shared/dialog_manager/services/dialog_service.dart';
import '../shared/methods/call_methods.dart';
import '../shared/network/constants/constants.dart';
import '../shared/network/controllers/network_controller.dart';
import '../shared/network/managers/network_manager.dart';

class BaseController extends GetxController
    with NetworkManager, ListenErrorGraphQL {
  var _hasNetwork = true;

  final _networkController = Get.find<NetworkController>();

  final isBadge = RxBool(false);

  final CallMethods callMethods = CallMethods();

  @override
  Future<void> onInit() async {
    super.onInit();

    // check network
    await checkConnectNetwork();

    AppDataGlobal.client
        ?.on(EventType.messageNew, EventType.notificationMessageNew)
        .listen((event) async {
      if (event.message?.user?.id ==
          AppDataGlobal.client?.state.currentUser?.id) {
        return;
      }

      if (event.message == null) {
        return;
      }
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        iOS: IOSInitializationSettings(),
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      final id = event.message?.id.hashCode;
      if (id == null) {
        return;
      }
      await flutterLocalNotificationsPlugin.show(
        id,
        event.message?.user?.name,
        event.message?.text,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'message channel',
            'Message channel',
            channelDescription: 'Channel used for showing messages',
            priority: Priority.high,
            importance: Importance.high,
          ),
          iOS: IOSNotificationDetails(),
        ),
      );
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> checkConnectNetwork() async {
    if (_networkController.connectionStatus.value == 0) {
      _hasNetwork = false;
      await callDialogErrorNetwork();
    }
    _networkController.connectionStatus.listen((status) {
      if (status == 0) {
        _hasNetwork = false;
        callDialogErrorNetwork();
      } else {
        _hasNetwork = true;
      }
    });
  }

  Future<void> callDialogErrorNetwork() async {
    final dialogRequest = CommonDialogRequest(
      title: 'Network error',
      description: 'Network error',
      defineEvent: NO_CONNECT_NETWORK,
    );
    await doShowDialog(dialogRequest);
  }

  Future<void> doShowDialog(CommonDialogRequest dialogRequest) async {
    final locator = Get.find<DialogService>();
    final dialogResult = await locator.showDialog(dialogRequest);

    if (dialogResult.confirmed) {
      print('User press confirm');
      await _handleEventDialog(dialogRequest.defineEvent);
    } else {
      print('User press cancel!');
    }
  }

  Future<void> _handleEventDialog(String? defineEvent) async {
    switch (defineEvent) {
      case NO_CONNECT_NETWORK:
        if (_hasNetwork == false) {
          await callDialogErrorNetwork();
        }
        break;
      default:
        break;
    }
  }

  CommonDialogRequest handleErrorResponse(Object e) {
    return handleErrorGraphQLResponse(e);
  }
}
