import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:ui_api/models/call/call_model.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';
import 'package:ui_api/models/invoice/invoice_status.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';
import 'package:ui_api/request/invoice/confirm_sub_request.dart';
import 'package:ui_api/request/invoice/rating_request.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/call_utilities.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/dialog/dialog_confirm_widget.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';
import '../../../shared/widget_hico/dialog/rating_widget.dart';
import '../../../shared/widget_hico/dialog/summary_working_widget.dart';
import '../../../shared/widget_hico/dialog/text_field_widget.dart';
import '../../../shared/widget_hico/invoice/cancel_invoice_widget.dart';

enum OrderInfoViewType { Text, Button, Status }

class OrderController extends BaseController {
  final Rx<int> showExtend = Rx(0);
  final _uiRepository = Get.find<HicoUIRepository>();
  final invoice = Rx(InvoiceModel());
  int id = 0;
  TextEditingController summaryControler = TextEditingController();
  Rx<ConfirmSubRequest> request = Rx(ConfirmSubRequest());

  @override
  Future<void> onInit() async {
    id = Get.arguments;
    await loadData();
    return super.onInit();
  }

  Future<void> loadData() async {
    await _uiRepository.getInfo().then((response) {
      if (response.status == CommonConstants.statusOk &&
          response.data != null &&
          response.data!.info != null) {
        AppDataGlobal.userInfo = response.data!.info!;
      }
    });
    await _uiRepository.invoiceDetail(id).then((response) {
      EasyLoading.dismiss();
      if (response.status == CommonConstants.statusOk &&
          response.data != null) {
        invoice.value = response.data!;
        return;
      } else {
        DialogUtil.showPopup(
          dialogSize: DialogSize.Popup,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          child: NormalWidget(
            icon: response.status == CommonConstants.statusOk
                ? IconConstants.icUserTag
                : IconConstants.icFail,
            title: response.message,
          ),
          onVaLue: (value) {
            Get.back();
          },
        );
      }
    });
  }

  Future<void> onChat() async {
    if (AppDataGlobal.client == null) {
      return;
    }
    final channel = AppDataGlobal.client!.channel(
      'messaging',
      id: invoice.value.getChatChannel(),
    );
    final _usersResponse = await AppDataGlobal.client?.queryUsers(
      filter: Filter.autoComplete('id', invoice.value.customerId.toString()),
    );
    await Get.toNamed(Routes.CHAT, arguments: {
      CommonConstants.INVOICE_ID: invoice.value.id,
      CommonConstants.CHANNEL: channel,
      CommonConstants.CHAT_USER: (_usersResponse?.users.isEmpty ?? true)
          ? invoice.value.getCustomer()
          : _usersResponse!.users.first,
      CommonConstants.IS_NOT_CALL: false,
    });
  }

  Future<void> onCall() async {
    if (AppDataGlobal.userInfo == null) {
      return;
    }
    final channelId = invoice.value.getCallChannel();

    try {
      await EasyLoading.show();
      await _uiRepository.getCallToken(channelId).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          // Get.toNamed(Routes.VOICE_CALL, arguments: response.data);
          final call = CallModel(
            invoiceId: invoice.value.id,
            callerId: AppDataGlobal.userInfo?.id,
            callerName: AppDataGlobal.userInfo?.name ?? '',
            callerPic: AppDataGlobal.userInfo?.avatarImage ?? '',
            receiverId: invoice.value.customerId,
            receiverName: invoice.value.customerName ?? '',
            receiverPic: invoice.value.customerAvatar ?? '',
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
    final channelId = invoice.value.getCallChannel();
    try {
      await EasyLoading.show();
      await _uiRepository.getCallToken(channelId).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          // Get.toNamed(Routes.VOICE_CALL, arguments: response.data);
          final call = CallModel(
            invoiceId: invoice.value.id,
            callerId: AppDataGlobal.userInfo?.id,
            callerName: AppDataGlobal.userInfo?.name ?? '',
            callerPic: AppDataGlobal.userInfo?.avatarImage ?? '',
            receiverId: invoice.value.customerId,
            receiverName: invoice.value.customerName ?? '',
            receiverPic: invoice.value.customerAvatar ?? '',
            channelId: channelId,
            hasDialled: true,
            isVideo: true,
          );
          CallUtils.dial(callMethods, call, response.data?.token ?? '');
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onExtend() async {}

  Future<void> onRating() async {
    try {
      await DialogUtil.showPopup(
        barrierDismissible: false,
        height: 397,
        backgroundColor: AppColor.primaryBackgroundColorLight,
        onPress: () {},
        child: RatingDialogWidget(
          id: id,
          height: 397,
          icon: invoice.value.customerAvatar,
          padding: 18,
          hintText: 'invoice.detail.hint_rating'.tr,
        ),
        onVaLue: (_value) {
          if (_value != null && _value is RatingRequest) {
            // call api rating
            // EasyLoading.show();
            // _uiRepository.editInvoiceRequest(id).then((response) {
            //   EasyLoading.dismiss();
            //   DialogUtil.showPopup(
            //     dialogSize: DialogSize.Popup,
            //     barrierDismissible: false,
            //     height: response.status == CommonConstants.statusOk ? 211 : 184,
            //     backgroundColor: AppColor.primaryBackgroundColorLight,
            //     onPress: () {},
            //     child: NormalWidget(
            //       height:
            //           response.status == CommonConstants.statusOk ? 211 : 184,
            //       icon: response.status == CommonConstants.statusOk
            //           ? IconConstants.edit
            //           : IconConstants.icFail,
            //       title: response.message,
            //     ),
            //     onVaLue: (value) {},
            //   );
            //   return;
            // });
          }
        },
      );
      return;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> cancel() async {
    try {
      await DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: false,
        height: invoice.value.isFined == 0 ? 292 : 270,
        backgroundColor: AppColor.primaryBackgroundColorLight,
        onPress: () {},
        child: TextDialogWidget(
          height: invoice.value.isFined == 0 ? 292 : 270,
          icon: invoice.value.isFined == 0
              ? IconConstants.icFund
              : IconConstants.icFail,
          padding: invoice.value.isFined == 0 ? 10 : 32,
          hintText: 'invoice.detail.hint_cancel'.tr,
          titleWidget: CancelInvoiceWidget(
            total: invoice.value.total!.toDouble(),
            isFined: invoice.value.isFined,
          ),
        ),
        onVaLue: (_value) {
          if (_value != null && _value is String) {
            //call api cancel
            EasyLoading.show();
            _uiRepository.invoiceCancel(id, _value).then((response) {
              EasyLoading.dismiss();
              DialogUtil.showPopup(
                dialogSize: DialogSize.Popup,
                barrierDismissible: false,
                backgroundColor: Colors.transparent,
                child: NormalWidget(
                  icon: IconConstants.icFail,
                  title: response.message,
                ),
                onVaLue: (value) {
                  loadData();
                },
              );
            });
          }
        },
      );
      return;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> confirm(int id, int status) async {
    try {
      await EasyLoading.show();
      if (status == InvoiceStatus.canceled.id) {
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
              await _uiRepository.invoiceConfirm(id, status).then((response) {
                loadData();
              });
            }
          },
        );
      } else {
        await _uiRepository.invoiceConfirm(id, status).then((response) {
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
          ).then((value) {
            loadData();
          });
          return;
        });
      }
      // return;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> start(int id) async {
    try {
      await EasyLoading.show();
      await _uiRepository.invoiceStart(id).then((response) {
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
        ).then((value) => loadData());
        return;
      });
      // return;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> completed(int id) async {
    try {
      await EasyLoading.show();
      await _uiRepository.invoiceCompleted(id).then((response) async {
        if (response.status == CommonConstants.statusOk) {
          if (invoice.value.service!.isMedical == 1) {
              await Get.toNamed(Routes.MEDICAL, arguments: id)!.then((value) => loadData());
          } else {
            await DialogUtil.showPopup(
              dialogSize: DialogSize.Popup,
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              child: const SummaryWorkingWidget(),
              onVaLue: (value) {
                log('Value: ${value.toString()}');
                if (value != null && value != '') {
                  request.value.invoiceId = id;
                  request.value.summary = summaryControler.text;
                  confirmSub(request.value);
                  loadData();
                }
              },
            );
          }
        }else{
          await DialogUtil.showPopup(
                dialogSize: DialogSize.Popup,
                barrierDismissible: false,
                backgroundColor: Colors.transparent,
                child: NormalWidget(
                  icon: IconConstants.icFail,
                  title: response.message,
                ),
                onVaLue: (value) {},
              );
        }
        return;
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> confirmSub(ConfirmSubRequest confirmSubRequest) async {
    try {
      await EasyLoading.show();
      await _uiRepository.confirmSub(confirmSubRequest).then((response) {
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
        ).then((value) {
          Get.back();
        });
        return;
      });
    } catch (error) {
      log(error.toString());
      await EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {}
}
