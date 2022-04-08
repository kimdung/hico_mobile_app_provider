part of 'address_service_screen.dart';

extension AddressServiceComponent on AddressServiceScreen {
  Widget buildTitleComponent({
    required String title,
    required int id,
    Function()? onPress,
  }) {
    return Container(
      child: BoxDecorationWidget(
        height: 45,
        border: Border(
          bottom: BorderSide(
            color: AppColor.borderGrayColorLight,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onPress,
          child: Container(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextAppStyle().normalTextStype()),
                (controller.provinced.value == id)
                    ? FCoreImage(
                        IconConstants.icChecked,
                        width: 24,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
