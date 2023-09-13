import 'package:flutter/material.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

class RecordCard extends StatelessWidget {
  final String title;
  final String text;
  final String amount;
  const RecordCard(
      {super.key,
      required this.amount,
      required this.text,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: KColor.grey.withOpacity(0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: KSize.getWidth(context, 247),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: KTextStyle.subtitle2
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 2,
                ),
                Text(text, style: KTextStyle.caption),
              ],
            ),
          ),
          Container(
            width: KSize.getWidth(context, 80),
            child: Text(
              " $amount",
              textAlign: TextAlign.right,
              style: KTextStyle.subtitle2.copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
