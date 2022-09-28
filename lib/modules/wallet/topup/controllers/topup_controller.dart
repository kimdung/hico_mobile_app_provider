import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ui_api/models/wallet/payment_method_item.dart';
import 'package:ui_api/models/wallet/topup_item.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../../data/app_data_global.dart';
import '../../../../resource/assets_constant/icon_constants.dart';
import '../../../../resource/assets_constant/images_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/utils/dialog_util.dart';
import '../../../../shared/widget_hico/dialog/dialog_confirm_widget.dart';
import '../../../../shared/widget_hico/dialog/normal_widget.dart';

class TopupController extends GetxController {
  final _uiRepository = Get.find<HicoUIRepository>();

  List<TopupItem> get topupItems => TopupItem.topupItems;
  RxInt selectedMoneyIndex = RxInt(0);

  final balance = RxInt(AppDataGlobal.userInfo?.accountBalance ?? 0);

  final formState = GlobalKey<FormState>();
  final moneyController = TextEditingController()
    ..text = TopupItem.topupItems.first.price.toString();

  RxInt selectedMethod = RxInt(0);
  List<PaymentMethodItem> get paymentMethods =>
      PaymentMethodItem.paymentMethods;

  @override
  void onClose() {
    printInfo(info: 'onClose');

    super.onClose();
  }

  /* Action */

  Future<void> onConfirm() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    final amount = double.tryParse(moneyController.text) ?? 0;
    if (amount == 0) {
      await EasyLoading.showToast('topup.amount.validate'.tr);
      return;
    }
    final amountTmp = amount + balance.value;
    if (amountTmp < 3000) {
      // await DialogUtil.showPopup(
      //   dialogSize: DialogSize.Popup,
      //   barrierDismissible: false,
      //   backgroundColor: Colors.transparent,
      //   child: NormalWidget(
      //     icon: IconConstants.icInfo,
      //     title: 'topup.notif'.tr,
      //   ),
      //   onVaLue: (value) {},
      // );

      await DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        child: DialogConfirmWidget(
          title: 'note'.tr,
          description: 'topup.notif'.tr,
          cancelTxt: 'cancel'.tr,
          acceptTxt: 'continue'.tr,
        ),
        onVaLue: (_value) {
          if (_value != null && _value is bool) {
            if (_value == true) {
              switch (selectedMethod.value) {
                case 0:
                  _topupBank(amount);
                  break;
                // case 1:
                //   await _topupKomaju(amount, 1);
                //   break;
                // case 2:
                //   await _topupKomaju(amount, 2);
                //   break;
                case 1:
                  Get.toNamed(Routes.TOPUP_STRIPE, arguments: amount)
                      ?.then((value) {
                    balance.value = AppDataGlobal.userInfo?.accountBalance ?? 0;
                  });
                  break;
                default:
                  break;
              }
            }
          }
        },
      );
    } else {
      switch (selectedMethod.value) {
        case 0:
          await _topupBank(amount);
          break;
        // case 1:
        //   await _topupKomaju(amount, 1);
        //   break;
        // case 2:
        //   await _topupKomaju(amount, 2);
        //   break;
        case 1:
          await Get.toNamed(Routes.TOPUP_STRIPE, arguments: amount)
              ?.then((value) {
            balance.value = AppDataGlobal.userInfo?.accountBalance ?? 0;
          });
          break;
        default:
          break;
      }
    }
  }

  Future<void> onSelectTopup(int index) async {
    selectedMoneyIndex.value = index;
    moneyController.text = topupItems[index].price.toString();
  }

  Future<void> onSelectPaymentMethod(int index) async {
    selectedMethod.value = index;
  }

  /* API */

  Future<void> _topupBank(double amount) async {
    try {
      await EasyLoading.show();
      await _uiRepository.topupBank(amount).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.row != null) {
          Get.toNamed(Routes.TOPUP_BANK, arguments: response.data!.row)
              ?.then((value) {
            balance.value = AppDataGlobal.userInfo?.accountBalance ?? 0;
          });
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> _topupKomaju(double amount, int type) async {
    try {
      await EasyLoading.show();
      await _uiRepository.topupKomaju(amount, type).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null) {
          // _payment(response.data!);
          Get.toNamed(Routes.TOPUP_KOMOJU, arguments: response.data!)
              ?.then((value) {
            balance.value = AppDataGlobal.userInfo?.accountBalance ?? 0;
          });
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
