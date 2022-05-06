import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hico/resource/assets_constant/icon_constants.dart';
import 'package:hico/resource/assets_constant/images_constants.dart';
import 'package:hico/shared/styles/text_style/text_style.dart';
import 'package:hico/shared/widgets/image_widget/fcore_image.dart';

import '../constants/colors.dart';
import '../styles/text_style/app_text_style.dart';

enum DialogSize { FullWidth, HalfWidth, Popup }

extension DialogSizeExtension on DialogSize {
  double get width {
    switch (this) {
      case DialogSize.HalfWidth:
        return Get.width * 0.5;
      case DialogSize.Popup:
        return Get.width * 0.35;
      default:
        return Get.width * 0.9;
    }
  }
}

class DialogUtil {
  DialogUtil._();

  static Future showAppDialog({
    String title = '',
    DialogSize dialogSize = DialogSize.FullWidth,
    required Widget child,
    Function(dynamic value)? onVaLue,
  }) async {
    await showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Container(
            decoration: BoxDecoration(
              color: AppColor.primaryTextColorLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.only(left: 20, right: 10),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.textStyle
                      .copyWith(color: AppColor.secondTextColorLight),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: 25,
                    color: AppColor.primaryBackgroundColorLight,
                  ),
                ),
              ],
            ),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: Container(width: dialogSize.width, child: child),
          ),
        );
      },
    ).then((value) => onVaLue);
  }

  static Future showPopup({
    String title = '',
    double? height,
    DialogSize dialogSize = DialogSize.FullWidth,
    bool barrierDismissible = false,
    required Widget child,
    int? action = 0,
    Color? backgroundColor,
    Function()? onPress,
    Function(dynamic value)? onVaLue,
  }) async {
    await showDialog(
      context: Get.overlayContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          //content: child,
          content: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: Container(
              width: dialogSize.width,
              height: height,
              child: child,
            ),
          ),
          // actions: ,
          backgroundColor: backgroundColor ?? Colors.white,
        );
      },
    ).then((value) => onVaLue!(value));
  }

  static Future showMenu() async {
    return showDialog(
      context: Get.overlayContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.topRight,
          insetPadding: const EdgeInsets.only(right: 24, top: 160),
          child: Container(
            width: 50,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'copied'.tr,
                textAlign: TextAlign.center,
                
              ),
            ),
          ),
        );
      },
    );
  }
}
