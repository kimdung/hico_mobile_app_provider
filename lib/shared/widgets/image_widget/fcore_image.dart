import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'skeleton_widget.dart';

class FCoreImage extends StatelessWidget {
  FCoreImage(
    this.source, {
    Key? key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeHolder,
    this.errorWidget,
    this.color,
    this.saveToLocal = false,
    this.isUrl = false,
  }) : super(key: key);

  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final Color? color;
  final bool saveToLocal;
  final bool isUrl;

  @override
  Widget build(BuildContext context) {
    if (source.isEmpty) {
      return const Placeholder();
    }

    if (isUrl || source.contains('http')) {
      return CachedNetworkImage(
        imageUrl: source,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => placeHolder ?? const Skeleton(),
        errorWidget: (context, url, error) =>
            errorWidget ?? placeHolder ?? const Skeleton(),
      );
    }
    if (source.contains('.svg')) {
      return SvgPicture.asset(
        source,
        fit: fit,
        color: color,
        width: width,
        height: height,
      );
    }
    return Image.asset(
      source,
      fit: fit,
      width: width,
      height: height,
    );
  }
}
