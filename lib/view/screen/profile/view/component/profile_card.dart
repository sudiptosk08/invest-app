import 'package:flutter/material.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import '../../../../utils/styles/k_colors.dart';

class ProfileCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  VoidCallback onTap;
  ProfileCategoryCard(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: KColor.grey.withOpacity(0.3)))),
        child: Row(
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
              width: 20,
            ),
            Text(
              title,
              style: KTextStyle.bodyText3,
            )
          ],
        ),
      ),
    );
  }
}
