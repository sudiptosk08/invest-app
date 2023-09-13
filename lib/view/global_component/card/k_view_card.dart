import 'package:flutter/material.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

// ignore: must_be_immutable

class KViewCard extends StatefulWidget {
  String count;
  String? ans;
  final String? question;

  KViewCard({
    Key? key,
    required this.count,
    required this.ans,
    required this.question,
  }) : super(key: key);

  @override
  _KViewCardState createState() => _KViewCardState();
}

class _KViewCardState extends State<KViewCard> {
  int secondaryIndex = -1;
  int primaryIndex = 0;

  void changeIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
  }

  void changePrimaryIndex(int index) {
    setState(() {
      primaryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (secondaryIndex == -1) {
              secondaryIndex = 0;
            } else {
              setState(() {
                secondaryIndex = -1;
              });
            }
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: KColor.white,
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: KColor.grey200!.withOpacity(0.8)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.question}",
                              style: KTextStyle.bodyText3,
                              maxLines: 6,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          )
                        ]),
                  ),
                  if (secondaryIndex == 0)
                    SizedBox(height: KSize.getHeight(context, 7)),
                  if (secondaryIndex == 0)
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              widget.ans!,
                              textAlign: TextAlign.justify,
                              style: KTextStyle.bodyText3
                                  .copyWith(color: KColor.grey),
                              maxLines: 6,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
