import 'package:flutter/material.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

import '../../../utils/styles/k_colors.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  VoidCallback onTap;
   CategoryCard(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: 
        onTap
      ,
      child: Column(
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
              color: KColor.primary,
              //colorBlendMode: ,
              filterQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: KTextStyle.caption,
          )
        ],
      ),
    );
  }
}
