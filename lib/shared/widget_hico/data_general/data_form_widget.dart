import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/time.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../constants/colors.dart';
import '../../styles/text_style/text_style.dart';
import '../../widgets/image_widget/fcore_image.dart';
import '../button/general_button.dart';

class DataFormWidget extends StatefulWidget {
  const DataFormWidget({Key? key, required this.dataList, required this.title, required this.currentSelected, })
      : super(key: key);

  final String title;
  final List<Time> dataList;
  final int currentSelected;

  @override
  State<DataFormWidget> createState() => _DataFormWidgetState();
}

class _DataFormWidgetState extends State<DataFormWidget> {
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _selected = widget.currentSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextAppStyle().titleAppBarStyle(),
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onSelect(widget.dataList[index].experienceCode);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.5,
                      bottom: 6.5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.dataList[index].content,
                            style: TextAppStyle().genaralTextStyle(),
                          ),
                        ),
                         widget.dataList[index].experienceCode == _selected
                            ? FCoreImage(
                                IconConstants.icSuccess,
                                width: 16.0,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) => const Divider(
                color: Color(0xFFC4C4C4),
              ),
              itemCount: widget.dataList.length,
            ),
            const SizedBox(
              height: 28.0,
            ),
            GeneralButton(
              onPressed: () {
                Navigator.pop(context, _selected);
              },
              borderRadius: BorderRadius.circular(24),
              borderColor: AppColor.primaryColorLight,
              backgroundColor: AppColor.primaryColorLight,
              child: Text(
                'save'.tr,
                style: TextAppStyle().titleButtonStyle(),
              ),
            )
          ],
        ),
      )
    ;
  }
  void onSelect(int value) {
    setState(() {
      _selected = value;
    });
  }
}
