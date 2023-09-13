import 'package:flutter/material.dart';

import '../../utils/styles/k_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.name,
      this.id,
      required this.onTap,
      required this.width,
      required this.height,
      required this.textColor,
      required this.color});
  final String name;
  final String? id;
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            name,
            style: KTextStyle.bodyText2.copyWith(color: textColor ),
          ),
        ),
      ),
    );
  }
}
