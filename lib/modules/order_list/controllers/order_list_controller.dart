import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';
import 'package:ui_api/models/invoice/invoice_status.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/dialog/dialog_confirm_widget.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';

class OrderListController extends BaseController {
  final _uiRepository = Get.find<HicoUIRepository>();
  final Channel adminChatChannel;

  final Rx<int> totalNotif = Rx(0);

  String keyword = '';

  final Rx<InvoiceStatus> currentStatus = Rx(InvoiceStatus.requested);
  final List<InvoiceStatus> invoiceStatus = InvoiceStatus.status;

  RxList<InvoiceModel> list = RxList<InvoiceModel>();

  final ScrollController scrollController = ScrollController();
  int limit = 4;
  int offset = 0;

  OrderListController(this.adminChatChannel) {
    loadList();
  }

  @override
  Future<void> onInit() async {
    await super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
          // offset = 0;
          // _loadNewsList();
        } else {
          _loadMore();
        }
      }
    });
  }

  Future<void> selectStatus(InvoiceStatus status) async {
    currentStatus.value = status;
    await loadList();
  }

  Future<void> onSearch(String text) async {
    keyword = text;
    await loadList();
  }

  Future<void> loadList() async {
    try {
      await EasyLoading.show();
      offset = 0;
      await _uiRepository
          .invoiceHistory(keyword, currentStatus.value.id, limit, offset)
          .then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.rows != null) {
          offset = response.data!.rows!.length;
          list.value = response.data!.rows!;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> _loadMore() async {
    try {
      await EasyLoading.show();
      await _uiRepository
          .invoiceHistory(keyword, currentStatus.value.id, limit, offset)
          .then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.rows != null) {
          if (response.data!.rows!.isNotEmpty) {
            offset += response.data!.rows!.length;
            list.addAll(response.data!.rows!);
          }
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> viewDetail(int id) async {
    await Get.toNamed(Routes.ORDER_DETAIL, arguments: id)
        ?.then((value) => loadList());
  }

  Future<void> confirm(int id, InvoiceStatus status) async {
    try {
      await EasyLoading.show();
      if (status == InvoiceStatus.canceled) {
        await EasyLoading.dismiss();
        await DialogUtil.showPopup(
          dialogSize: DialogSize.Popup,
          barrierDismissible: false,
          height: 160,
          backgroundColor: AppColor.primaryBackgroundColorLight,
          child: DialogConfirmWidget(
            height: 160,
            description: 'order.cancel_confirm'.tr,
          ),
          onVaLue: (_value) async {
            if (_value == true) {
              await _uiRepository
                  .invoiceConfirm(id, status.id)
                  .then((response) {
                loadList();
              });
            }
          },
        );
      } else {
        await _uiRepository.invoiceConfirm(id, status.id).then((response) {
          EasyLoading.dismiss();
          DialogUtil.showPopup(
            dialogSize: DialogSize.Popup,
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            child: NormalWidget(
              icon: response.status == CommonConstants.statusOk
                  ? IconConstants.icSuccess
                  : IconConstants.icFail,
              title: response.message,
            ),
            onVaLue: (value) {},
          ).then((value) => loadList());
          return;
        });
      }
      // return;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onChatAdmin() async {
    if (AppDataGlobal.client == null) {
      return;
    }
    final _usersResponse = await AppDataGlobal.client?.queryUsers(
      filter: Filter.autoComplete(
          'id', AppDataGlobal.userInfo?.conversationInfo?.adminId ?? ''),
    );

    await Get.toNamed(Routes.CHAT, arguments: {
      CommonConstants.CHANNEL: adminChatChannel,
      CommonConstants.CHAT_USER: (_usersResponse?.users.isEmpty ?? true)
          ? AppDataGlobal.userInfo?.conversationInfo?.getAdmin()
          : _usersResponse!.users.first,
    });
  }

  Future<void> onChat(InvoiceModel invoice) async {
    if (AppDataGlobal.client == null) {
      return;
    }
    final channel = AppDataGlobal.client!
        .channel('messaging', id: invoice.getChatChannel());
    final _usersResponse = await AppDataGlobal.client?.queryUsers(
      filter: Filter.autoComplete('id', invoice.customerId.toString()),
    );

    await Get.toNamed(Routes.CHAT, arguments: {
      CommonConstants.CHANNEL: channel,
      CommonConstants.CHAT_USER: (_usersResponse?.users.isEmpty ?? true)
          ? invoice.getCustomer()
          : _usersResponse!.users.first,
    });
  }

  Future<void> onCall(InvoiceModel invoice) async {}

  Future<void> onVideo(InvoiceModel invoice) async {}
}
