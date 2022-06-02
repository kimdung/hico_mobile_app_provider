import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ui_api/models/master_data/master_data_model.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';
import '../../styles/text_style/text_style.dart';
import '../box_decoration/box_decoration.dart';

class LevelWidget extends StatefulWidget {
  const LevelWidget({
    Key? key,
    required this.levels,
  }) : super(key: key);

  final List<LevelModel> levels;

  @override
  State<LevelWidget> createState() => _LevelWidgetState();
}

class _LevelWidgetState extends State<LevelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'supplier.filter.level'.tr,
            style: TextAppStyle().largeTextStype(),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CommonConstants.paddingDefault),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    widget.levels.length,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.pop(context, widget.levels[index]);
                      },
                      child: BoxDecorationWidget(
                        height: 45,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.borderGrayColorLight,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.levels[index].name ?? '',
                            textAlign: TextAlign.left,
                            style: widget.levels[index].isFeatured == 1
                                ? TextAppStyle().normalTextPink()
                                : TextAppStyle().normalTextStype(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
