part of 'category_service_screen.dart';

extension CategoryServiceComponent on CategoryServiceScreen {
  Widget buildTitleComponent({
    required String title,
    bool prefixIcon = true,
    Alignment? alignment,
    Function()? onPress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: BoxDecorationWidget(
        height: 47,
        radius: 8,
        shadow: true,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onPress,
                child: Container(
                  padding: const EdgeInsets.only(left: 14),
                  alignment: alignment,
                  child: Text(title, style: TextAppStyle().normalTextPink()),
                ),
              ),
            ),
            if (prefixIcon)
              InkWell(
                onTap: onPress,
                child: FCoreImage(
                  IconConstants.icArrowDown,
                  width: 16,
                ),
              ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
