import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AppGradientBorderButton extends StatelessWidget {
  const AppGradientBorderButton({
    required this.onPressed,
    required this.child,
    this.height = 48,
    Key? key,
    this.borderRadius,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget child;
  final BorderRadius? borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColorLight),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
