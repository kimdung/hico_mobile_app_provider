import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hico/resource/assets_constant/icon_constants.dart';
import 'package:hico/shared/constants/colors.dart';
import 'package:hico/shared/constants/common.dart';
import 'package:hico/shared/decoration/text_field_decoration.dart';
import 'package:hico/shared/styles/text_style/text_style.dart';
import 'package:hico/shared/widget_hico/button/general_button.dart';
import 'package:hico/shared/widget_hico/image_widget/network_image.dart';
import 'package:hico/shared/widgets/image_widget/fcore_image.dart';
import 'package:ui_api/request/invoice/rating_request.dart';

class RatingDialogWidget extends StatelessWidget {
  RatingDialogWidget({
    Key? key,
    this.id,
    this.icon,
    this.title,
    this.height,
    this.titleBtn,
    this.hintText,
    this.titleWidget,
    this.padding,
    this.ratingRequest,
  }) : super(key: key);

  final int? id;
  final String? icon;
  final String? title;
  final double? height;
  final double? padding;
  final String? titleBtn;
  final String? hintText;
  final Widget? titleWidget;
  RatingRequest? ratingRequest;
  @override
  Widget build(BuildContext context) {
    var contents = '';
    var star = 5;
    return SingleChildScrollView(
      child: Container(
        height: height ?? 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 11),
                  Text(
                    'order.detail.rating_title'.tr,
                    style: TextAppStyle().normalTextStype(),
                  ),
                  const SizedBox(height: 23),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: padding ?? 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NetWorkImage(
                          image: icon ?? '',
                          width: 68,
                        ),
                        const SizedBox(height: 5),
                        RatingBar.builder(
                          initialRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, _) =>
                              _image(IconConstants.icStarColor),
                          onRatingUpdate: (rating) {
                            print(rating);
                            star = rating.toInt();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        contents = value;
                      },
                      maxLines: 8,
                      decoration: TextFieldDecoration.borderOutline(
                        backgroundColor: AppColor.primaryBackgroundColorLight,
                        borderColor: AppColor.sixTextColorLight,
                        hintText: hintText,
                        hintStype: TextAppStyle().smallTextGrey(),
                        radius: 6,
                      ),
                      style: TextStyle(
                          color: AppColor.dividerColorLight,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.paddingDefault),
              child: GeneralButton(
                // ignore: sort_child_properties_last
                child: Text(
                  'confirm'.tr,
                  style: TextAppStyle().normalTextWhite(),
                ),
                borderColor: AppColor.primaryColorLight,
                backgroundColor: AppColor.primaryColorLight,
                borderRadius: BorderRadius.circular(24),
                onPressed: () {
                  Navigator.pop(context, RatingRequest(id, star, contents));
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 40,
      width: 40,
    );
  }
}
