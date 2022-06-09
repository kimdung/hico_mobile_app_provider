import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../shared/constants/common.dart';
import '../../account/controllers/account_controller.dart';
import '../../account/views/account_screen.dart';
import '../../news/controllers/news_controller.dart';
import '../../news/views/news_screen.dart';
import '../../notification/controllers/notification_controller.dart';
import '../../notification/views/notification_screen.dart';
import '../../order_list/controllers/order_list_controller.dart';
import '../../order_list/views/order_list_screen.dart';

class MainController extends BaseController {
  Rx<int> index = Rx(0);
  Rx<int> badge = Rx(0);
  final _uiRepository = Get.find<HicoUIRepository>();

  final channel = AppDataGlobal.client?.channel('messaging',
      id: AppDataGlobal.userInfo?.conversationInfo?.getAdminChannel() ?? '');

  List<Widget> tabs = <Widget>[];
  late OrderListController orderListController;
  late NotificationController notificationController;
  final newsController = NewsController();
  final accountController = AccountController();

  MainController() {
    orderListController = OrderListController(channel);
    notificationController = NotificationController(this);
    tabs = [
      OrderListScreen(orderListController),
      NotificationScreen(notificationController),
      NewsScreen(newsController),
      AccountScreen(accountController),
    ];
  }
  @override
  Future<void> onInit() async {
    await super.onInit();
    await orderListController.loadList();
    await channel?.watch();
    channel?.state?.unreadCountStream.listen((event) {
      orderListController.badgeChatAdmin.value = event;
    });
    await orderListController.loadList();
    await countNotifyUnread();
  }

  Future<void> changeIndex(int _index) async {
    if (_index != index.value) {
      if (_index == 0) {
        await orderListController.loadList();
      } else if (_index == 1) {
        await notificationController.loadData();
      } else if (_index == 2) {
        await newsController.loadNewsList();
      } else if (_index == 3) {
        await accountController.loadData();
      }
    }

    index.value = _index;

    await countNotifyUnread();
  }

  Future<void> countNotifyUnread() async {
    await _uiRepository.notificationUnRead().then((response) {
      if (response.status == CommonConstants.statusOk &&
          response.data != null) {
        badge.value = response.data!;
      }
    });
  }
}
