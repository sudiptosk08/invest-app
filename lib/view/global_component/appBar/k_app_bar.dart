import "package:flutter/material.dart";
import "package:invest_app/view/utils/styles/k_colors.dart";
import "package:invest_app/view/utils/styles/k_text_style.dart";

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 55.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          transform: GradientRotation(1),
          end: Alignment.bottomCenter,
          colors: [
            KColor.secondPrimary,
            KColor.primary,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title == "Profile" ||
                  title == "Product" ||
                  title == "Banner" ||
                  title == "About"
              ? Container(
                  padding: const EdgeInsets.only(left: 18.0),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: KColor.white,
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: Text(
                title,
                style: KTextStyle.subtitle1.copyWith(color: KColor.white),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
