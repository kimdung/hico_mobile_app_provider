import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart' as callevent;
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:ui_api/models/notifications/notification_data.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../data/app_data_global.dart';
import '../../routes/app_pages.dart';
import '../constants/common.dart';
import '../constants/storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();

  final notificationData = NotificationData.fromJson(message.data);
  if (notificationData.displayType == NotificationData.typeIncomingCall) {
    await showCallkitIncoming(notificationData);
  }
}

Future<void> showCallkitIncoming(NotificationData notificationData) async {
  if (notificationData.receiverId == null) {
    return;
  }

  try {
    final callCollection = FirebaseFirestore.instance.collection('call');
    callCollection
        .doc(notificationData.receiverId)
        .snapshots()
        .listen((DocumentSnapshot ds) {
      if (ds.data() == null) {
        FlutterCallkitIncoming.endAllCalls();
      }
    });
  } catch (e) {
    debugPrint('[FirebaseMessageConfig] $e');
  }
  try {
    if (Platform.isIOS) {
      SharedPreferencesIOS.registerWith();
    } else if (Platform.isAndroid) {
      SharedPreferencesAndroid.registerWith();
    }
    final sp = await SharedPreferences.getInstance();
    final locale = sp.getString(StorageConstants.language) ?? VIETNAMESE_LANG;

    final String handle, textAccept, textDecline, textMissedCall, textCallback;
    switch (locale) {
      case ENGLISH_LANG:
        handle = (notificationData.callIsVideo == 'true')
            ? 'Incoming video call...'
            : 'Incoming voice call...';
        textAccept = 'Accept';
        textDecline = 'Decline';
        textMissedCall = 'Missed Call';
        textCallback = 'Callback';
        break;
      case JAPANESE_LANG:
        handle = (notificationData.callIsVideo == 'true')
            ? 'ビデオ通話の着信...'
            : '音声通話の着信...';
        textAccept = '承認';
        textDecline = '却下';
        textMissedCall = '不在着信';
        textCallback = '折り返し電話';
        break;
      default:
        handle = (notificationData.callIsVideo == 'true')
            ? 'Có cuộc gọi video...'
            : 'Có cuộc gọi âm thanh...';
        textAccept = 'Chấp nhận';
        textDecline = 'Từ chối';
        textMissedCall = 'Có cuộc gọi nhỡ';
        textCallback = 'Gọi lại';
    }
    final params = CallKitParams(
      id: notificationData.callId ?? const Uuid().v4(),
      nameCaller: notificationData.callerName ?? '',
      appName: 'HICO Provider',
      avatar: notificationData.callerPic,
      handle: handle,
      type: notificationData.callIsVideo == 'true' ? 1 : 0,
      duration: 60000,
      textAccept: textAccept,
      textDecline: textDecline,
      textMissedCall: textMissedCall,
      textCallback: textCallback,
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        isShowCallback: false,
        isShowMissedCallNotification: true,
        ringtonePath: 'bell',
        backgroundColor: '#DF4D6F',
        // incomingCallNotificationChannelName,
        // missedCallNotificationChannelName,
      ),
      ios: IOSParams(
        iconName: 'AppIcon',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'bell',
      ),
    );
    // final params = <String, dynamic>{
    //   'id': notificationData.callId ?? const Uuid().v4(),
    //   'appName': 'HICO Provider',
    //   'nameCaller': notificationData.callerName ?? '',
    //   'avatar': notificationData.callerPic,
    //   'handle': handle,
    //   'type':
    //       (Platform.isIOS || (notificationData.callIsVideo == 'true')) ? 1 : 0,
    //   'duration': 60000,
    //   'textAccept': textAccept,
    //   'textDecline': textDecline,
    //   'textMissedCall': textMissedCall,
    //   'textCallback': textCallback,
    //   'android': <String, dynamic>{
    //     'isCustomNotification': true,
    //     'isShowLogo': false,
    //     'isShowCallback': false,
    //     'isShowMissedCallNotification': true,
    //     'ringtonePath': 'bell',
    //     'backgroundColor': '#DF4D6F',
    //   },
    //   'ios': <String, dynamic>{
    //     'iconName': 'AppIcon',
    //     'handleType': 'generic',
    //     'supportsVideo': true,
    //     'maximumCallGroups': 2,
    //     'maximumCallsPerCallGroup': 1,
    //     'audioSessionMode': 'default',
    //     'audioSessionActive': true,
    //     'audioSessionPreferredSampleRate': 44100.0,
    //     'audioSessionPreferredIOBufferDuration': 0.005,
    //     'supportsDTMF': true,
    //     'supportsHolding': true,
    //     'supportsGrouping': false,
    //     'supportsUngrouping': false,
    //     'ringtonePath': 'bell.caf'
    //   }
    // };
    FlutterCallkitIncoming.onEvent.listen((event) async {
      switch (event?.event) {
        case callevent.Event.ACTION_CALL_INCOMING:
          break;
        case callevent.Event.ACTION_CALL_START:
          break;
        case callevent.Event.ACTION_CALL_ACCEPT:
          AppDataGlobal.acceptCall = true;
          await sp.setBool(StorageConstants.isAcceptCall, true);
          break;
        case callevent.Event.ACTION_CALL_DECLINE:
          try {
            final callCollection =
                FirebaseFirestore.instance.collection('call');
            await callCollection
                .doc(notificationData.callerId.toString())
                .delete();
            await callCollection
                .doc(notificationData.receiverId.toString())
                .delete();
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        default:
          break;
      }
    });
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  } catch (e) {
    debugPrint('[FirebaseMessageConfig] $e');
  }
}

class FirebaseMessageConfig {
  FirebaseMessageConfig._();

  static final instance = FirebaseMessageConfig._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _androidNotificationChannel = const AndroidNotificationChannel(
    'hico_provider_high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
    playSound: true,
    showBadge: true,
  );

  Future<void> initFirebaseMessageConfig() async {
    await _initFirebaseMessaging();
    await _initLocalNotification();
  }

  Future<void> _initFirebaseMessaging() async {
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      // Hiển thị notification khi bật app cho ios
      if (Platform.isIOS) {
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
      await _firebaseMessaging.setAutoInitEnabled(true);

      await _handleTokenFirebase();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _initLocalNotification() async {
    try {
      const initialzationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
        onDidReceiveLocalNotification:
            (int? id, String? title, String? body, String? payload) async {
          if (payload?.isNotEmpty ?? false) {
            /// ['id']: Key json chứa ID của thông báo server trả về.
            /// Dùng để điều hướng vào màn chi tiết thông báo
            /// Mặc định đang là ['id']
            // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
            //   DetailNotificationScreen.routeName,
            //   arguments: int.tryParse(
            //     json.decode(payload)['id']?.toString(),
            //   ),
            // );
          }
        },
      );

      final initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            didReceiveBackgroundNotificationResponseCallback,
        onDidReceiveNotificationResponse:
            didReceiveNotificationResponseCallback,
      );

      if (Platform.isIOS) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (Platform.isAndroid) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_androidNotificationChannel);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> handleMessage() async {
    try {
      /// Lấy tất cả thông báo khiến ứng dụng mở từ terminated state
      /// Một khi lấy ra thông báo để điều hướng, nó sẽ bị remove
      /// Tương tác với thông báo khi ứng dụng đang ở terminated
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        if (initialMessage.data.isNotEmpty) {
          /// ['id']: Key json chứa ID của thông báo server trả về.
          /// Dùng để điều hướng vào màn chi tiết thông báo
          /// Mặc định đang là ['id']
          // Navigator.of(AppConfig.navigatorKey.currentContext).pushNamed(
          //   DetailNotificationScreen.routeName,
          //   arguments: int.tryParse(
          //     initialMessage?.data['id']?.toString(),
          //   ),
          // );
        }
      }

      /// Khi đang mở ứng dụng, thông báo Firebase sẽ vào hàm onMessage
      /// Android sẽ block toàn bộ thông báo đẩy, cần cấu hình thêm thư viện
      /// flutter_local_notifications để hiển thị thông báo cũng như tương tác
      /// thông báo IOS cần call setForegroundNotificationPresentationOptions
      /// để nhận thông báo khi đang mở ứng dụng
      FirebaseMessaging.onMessage.listen(_showNotification);

      /// Tương tác với thông báo khi ứng dụng đang ở background và khi đang
      /// khóa màn hình
      FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _showNotification(RemoteMessage message) {
    debugPrint(
        '[FirebaseMessageConfig] Got a message whilst in the foreground! data: ${message.data}');
    reloadBalance();
    try {
      debugPrint('[FirebaseMessageConfig] RemoteMessage $message');
      final remoteNotification = message.notification;
      final android = message.notification?.android;

      if (remoteNotification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidNotificationChannel.id,
              _androidNotificationChannel.name,
              importance: Importance.max,
              visibility: NotificationVisibility.public,
              priority: Priority.max,
              playSound: true,
              enableLights: true,
              enableVibration: true,
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              subtitle: remoteNotification.title,
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    } catch (e) {
      debugPrint('[FirebaseMessageConfig] $e');
    }
  }

  static Future didReceiveBackgroundNotificationResponseCallback(
      NotificationResponse details) async {
    debugPrint(
        '[FirebaseMessageConfig] onDidReceiveBackgroundNotificationResponse $details');

    if (details.payload?.isEmpty ?? true) {
      return;
    }
    final message = jsonDecode(details.payload ?? '');
    await onSelectNotifcation(message);
  }

  static Future didReceiveNotificationResponseCallback(
      NotificationResponse details) async {
    if (details.payload?.isEmpty ?? true) {
      return;
    }
    final message = jsonDecode(details.payload ?? '');
    await onSelectNotifcation(message);
  }

  static Future onMessageOpenedApp(RemoteMessage message) async {
    /// ['id']: Key json chứa ID của thông báo server trả về.
    /// Dùng để điều hướng vào màn chi tiết thông báo
    /// Mặc định đang là ['id']
    if (message.data.isEmpty) {
      return;
    }
    debugPrint('[FirebaseMessageConfig] onMessageOpenedApp');
    await onSelectNotifcation(message.data);
  }

  static Future onSelectNotifcation(Map<String, dynamic> message) async {
    debugPrint('[FirebaseMessageConfig] ONTAP NOTIFICATION: $message');

    final notificationData = NotificationData.fromJson(message);

    //FCM Firebase
    final type = notificationData.displayType;
    final id = int.tryParse(notificationData.invoiceId ?? '');

    //FCM GetStream
    final sender = notificationData.sender;
    final channelId = message['channel_id'] ?? '';
    if (sender == 'stream.chat' && channelId.isNotEmpty) {
      //router chat screen
      debugPrint('[FirebaseMessageConfig] router chat screen');

      await onChat(channelId, false);
      return;
    }

    switch (type) {
      case NotificationData.typeSupplierReviewProfile:
        // do something else 2
        await Get.toNamed(Routes.ACCOUNT);
        break;
      case NotificationData.typeSupplierAgreeCustomer:
        // do something else 3
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierCancel:
        // do something else 4
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierNewInvoice:
        // do something else 5
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeCustomerCancel:
        // do something else 6
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeCustomerExtendPeriod:
        // do something else 7
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierCompleted:
        // do something else 8
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeTravelingCosts:
        // do something else 9
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeTimeReminder:
        // do something else 10
        await Get.toNamed(Routes.ACCOUNT);
        break;
      case NotificationData.typeAdminApproved:
        // do something else 11
        await Get.toNamed(Routes.MAIN);
        break;
      case NotificationData.typeSystemStart:
        // do something else 12
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSendNotifyTimeout:
        // do something else 13
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeAdminApprovedWallet:
        // do something else 14
        await Get.toNamed(Routes.WALLET);
        break;
      case NotificationData.typeMissedCall:
        // do something else 16
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierOvertime:
        // do something else 17
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSystemCancel:
        // do something else 18
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSystemSendBefore10:
        // do something else 19
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSystemSendBefore5:
        // do something else 20
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierAgreeExtend:
        // do something else 21
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierRefuseExtend:
        // do something else 22
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeSupplierRefuseCustomer:
        // do something else 23
        await Get.toNamed(Routes.ORDER_DETAIL, arguments: id);
        break;
      case NotificationData.typeAdminTransferUser:
        // do something else 24
        await Get.toNamed(Routes.STATISTIC);
        break;
      default:
        break;
    }
  }

  Future<void> resetDeviceToken() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> _handleTokenFirebase() async {
    await _firebaseMessaging.getToken().then((String? token) async {
      debugPrint('[FirebaseMessageConfig] FIREBASE TOKEN: $token');
      if (token != null) {
        AppDataGlobal.firebaseToken = token;
        await AppDataGlobal.client?.addDevice(token, PushProvider.firebase);
      }
    });
    _firebaseMessaging.onTokenRefresh.listen((token) {
      debugPrint('[FirebaseMessageConfig] TOKEN FIREBASE CHANGE: $token');
      AppDataGlobal.firebaseToken = token;
      AppDataGlobal.client?.addDevice(token, PushProvider.firebase);
    });
  }

  static Future<void> onChat(String channelId, bool? isNotCall) async {
    if (AppDataGlobal.client == null) {
      return;
    }
    final channel = AppDataGlobal.client!.channel('messaging', id: channelId);
    final ids = channelId.split('-');
    final userId = ids
        .firstWhereOrNull((id) => id != AppDataGlobal.userInfo?.id.toString());
    if (userId == null) {
      return;
    }
    await AppDataGlobal.client
        ?.queryUsers(filter: Filter.autoComplete('id', userId))
        .then((response) {
      if (response.users.isEmpty) {
        return;
      }
      Get.toNamed(Routes.CHAT, arguments: {
        CommonConstants.CHANNEL: channel,
        CommonConstants.CHAT_USER: response.users.first,
      });
    });
  }

  Future<void> reloadBalance() async {
    try {
      final _uiRepository = Get.find<HicoUIRepository>();

      await _uiRepository.getInfo().then((response) {
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.info != null) {
          AppDataGlobal.userInfo = response.data!.info!;
        }
      });
    } catch (e) {
      debugPrint('[FirebaseMessageConfig] $e');
    }
  }
}
