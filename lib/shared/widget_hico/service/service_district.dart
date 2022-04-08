import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ui_api/models/master_data/districts_model.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../constants/colors.dart';
import '../../constants/common.dart';
import '../../styles/text_style/text_style.dart';
import '../../widgets/image_widget/fcore_image.dart';
import '../box_decoration/box_decoration.dart';

class DistrictServiceWidget extends StatefulWidget {
  const DistrictServiceWidget({
    Key? key,
    required this.districts,
    required this.districtSelected,
  }) : super(key: key);

  final List<DistrictsModel> districts;
  final List<int> districtSelected;

  @override
  State<DistrictServiceWidget> createState() => _DistrictServiceWidgetState();
}

class _DistrictServiceWidgetState extends State<DistrictServiceWidget> {
  List<DistrictsModel> _filterList = [];
  List<DistrictsModel> _choosedList = [];
  bool allItem = false;
  @override
  void initState() {
    super.initState();
    _choosedList = widget.districts
        .where((element) => widget.districtSelected.contains(element.id))
        .toList();
    onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.paddingDefault),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: CommonConstants.paddingDefault * 2),
                      //width: double.infinity,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColor.secondBackgroundColorLight,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextField(
                        onSubmitted: onSearch,
                        style: TextAppStyle().normalTextPink(),
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'service.address.search_district'.tr,
                            hintStyle: TextAppStyle().normalTextPink(),
                            prefixIcon: Image.asset(IconConstants.icSearch),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 7)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, _choosedList);
                    },
                    child: Text(
                      'done'.tr,
                      style: TextAppStyle().normalTextPink(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.paddingDefault),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxDecorationWidget(
                      height: 45,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColor.borderGrayColorLight,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'all'.tr,
                            style: TextAppStyle().normalTextPink(),
                          ),
                          InkWell(
                            onTap: selectAll,
                            child: FCoreImage(
                              allItem
                                  ? IconConstants.icCheckedbox
                                  : IconConstants.icCheckbox,
                              width: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(
                      _filterList.length,
                      (index) => BoxDecorationWidget(
                        height: 45,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.borderGrayColorLight,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _filterList[index].name ?? '',
                                textAlign: TextAlign.left,
                                style: TextAppStyle().normalTextStype(),
                              ),
                              InkWell(
                                onTap: () {
                                  selectService(_filterList[index]);
                                },
                                child: FCoreImage(
                                  _choosedList.contains(_filterList[index])
                                      ? IconConstants.icCheckedbox
                                      : IconConstants.icCheckbox,
                                  width: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSearch(String key) {
    setState(() {
      _filterList = widget.districts
          .where((element) =>
              element.name != null &&
              element.name!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    });
  }

  void selectAll() {
    setState(() {
      allItem = !allItem;
      if (allItem) {
        _choosedList = _filterList;
      } else {
        _choosedList = [];
      }
    });
  }

  void selectService(DistrictsModel item) {
    setState(() {
      if (_choosedList.contains(item)) {
        _choosedList.remove(item);
      } else {
        _choosedList.add(item);
      }
    });
  }
}
