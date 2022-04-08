import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../button/general_button.dart';

class DialogConfirmWidget extends StatefulWidget {
  const DialogConfirmWidget(
      {Key? key, this.title, required this.description, this.height})
      : super(key: key);

  final double? height;
  final String? title;
  final String description;

  @override
  State<DialogConfirmWidget> createState() => _DialogConfirmWidgetState();
}

class _DialogConfirmWidgetState extends State<DialogConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 14),
                  (widget.title != null)
                      ? Text(
                          widget.title!,
                          textAlign: TextAlign.center,
                          style: TextAppStyle().largeTextStype(),
                        )
                      : Container(),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextAppStyle().normalTextGrey(),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GeneralButton(
                  borderColor: AppColor.primaryColorLight,
                  backgroundColor: AppColor.primaryColorLight,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'order.detail.cancel'.tr,
                    style: TextAppStyle().normalTextWhite(),
                  ),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: GeneralButton(
                  borderColor: AppColor.primaryColorLight,
                  backgroundColor: AppColor.primaryColorLight,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'accept'.tr,
                    style: TextAppStyle().normalTextWhite(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
