part of 'rating_screen.dart';

extension RatingExtension on RatingScreen {
  Widget starItem({
    required int star,
    int? total,
    Function()? onPress,
  }) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColor.secondBackgroundColorLight,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              width: 1,
              color: controller.currentStar.value == star
                  ? AppColor.primaryColorLight
                  : AppColor.secondBackgroundColorLight),
        ),
        child: (star == 0)
            ? Text(
                '${'all'.tr} (${total ?? 0})',
                style: TextAppStyle().normalTextPink(),
              )
            : Row(
                children: [
                  ...List.generate(
                    star,
                    (int index) => FCoreImage(IconConstants.icStarRadius),
                  ),
                  Text(
                    ' (${total ?? 0})',
                    style: TextAppStyle().normalTextPink(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget ratingItem({required RatingModel item}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondColorLight.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 27),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: NetWorkImage(
                image: item.customerAvatar ?? '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.invoiceCode ?? '',
                      style: TextAppStyle().normalTextStype().copyWith(
                            color: AppColor.blueTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      item.createdAt ?? '',
                      style: TextAppStyle().smallTextGrey(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ...List.generate(
                      item.numberStar ?? 0,
                      (int index) => FCoreImage(IconConstants.icStarRadius),
                    ),
                  ],
                ),
                Text(
                  item.content ?? '',
                  style: TextAppStyle().normalTextStype(),
                ),
                Text(
                  '${'invoice.service'.tr} ${item.serviceName ?? ''}',
                  style: TextAppStyle().smallTextGrey(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
