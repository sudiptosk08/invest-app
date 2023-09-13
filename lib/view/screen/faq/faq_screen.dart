import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/card/k_view_card.dart';
import 'package:invest_app/view/screen/faq/controller/faq_controller.dart';
import 'package:invest_app/view/screen/faq/model/faq_model.dart';
import 'package:invest_app/view/screen/faq/state/faq_state.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

import '../../utils/styles/k_colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final faqListState = ref.watch(getFaqListProvider);
      final List<FaqDatum> faqList = faqListState is FetchFaqListSuccessState
          ? faqListState.getfaqListModel!.data
          : [];
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: GradientAppBar("FAQ    ")),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (faqListState is LoadingState) ...[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Loading ...",
                          style:
                              KTextStyle.bodyText3.copyWith(color: KColor.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CircularProgressIndicator(
                          color: KColor.primary,
                        )
                      ],
                    ),
                  ),
                ],
                if (faqListState is FetchFaqListSuccessState) ...[
                  ...List.generate(
                      faqList.length,
                      (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KViewCard(
                                    count: "",
                                    question: faqList[index].title,
                                    ans: faqList[index].description),
                              ]))
                ]
              ],
            ),
          ),
        ),
      );
    });
  }
}
