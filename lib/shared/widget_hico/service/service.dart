import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ui_api/models/home/services_model.dart';

import '../../../resource/assets_constant/icon_constants.dart';
import '../../constants/colors.dart';
import '../../constants/common.dart';
import '../../styles/text_style/text_style.dart';
import '../../widgets/image_widget/fcore_image.dart';
import '../box_decoration/box_decoration.dart';

class ServiceWidget extends StatefulWidget {
  const ServiceWidget({
    Key? key,
    required this.services,
    required this.servicesSelected,
  }) : super(key: key);

  final List<ServiceModel> services;
  final List<int> servicesSelected;

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  List<ServiceModel> _filterServices = [];
  List<ServiceModel> _choosedService = [];
  bool allItem = false;
  @override
  void initState() {
    super.initState();
    _choosedService = widget.services
        .where((element) => widget.servicesSelected.contains(element.id))
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
                            hintText: 'service.category.search_service'.tr,
                            hintStyle: TextAppStyle().normalTextPink(),
                            prefixIcon: Image.asset(IconConstants.icSearch),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 7)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, _choosedService);
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
                      _filterServices.length,
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
                                _filterServices[index].name ?? '',
                                textAlign: TextAlign.left,
                                style: TextAppStyle().normalTextStype(),
                              ),
                              InkWell(
                                onTap: () {
                                  selectService(_filterServices[index]);
                                },
                                child: FCoreImage(
                                  _choosedService
                                          .contains(_filterServices[index])
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
      _filterServices = widget.services
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
        _choosedService = _filterServices;
      } else {
        _choosedService = [];
      }
    });
  }

  void selectService(ServiceModel service) {
    setState(() {
      if (_choosedService.contains(service)) {
        _choosedService.remove(service);
      } else {
        _choosedService.add(service);
      }
    });
  }
}
