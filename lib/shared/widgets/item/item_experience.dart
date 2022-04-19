import 'package:flutter/material.dart';
import '../../styles/text_style/text_style.dart';

class ItemExperience extends StatelessWidget {
  const ItemExperience({Key? key, required this.content}) : super(key: key);

  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.5,
        bottom: 6.5,
      ),
      child: Text(
        content,
        style: TextAppStyle().genaralTextStyle(),
      ),
    );
  }
}
