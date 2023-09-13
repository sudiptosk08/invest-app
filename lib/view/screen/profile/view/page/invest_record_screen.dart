import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/profile/controller/invest_record_controller.dart';
import 'package:invest_app/view/screen/profile/model/invest_record_history_model.dart';
import 'package:invest_app/view/screen/profile/state/invest_record_histroy_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

import '../../../../global_component/record_list_card/record_card.dart';

class InvestRecordScreen extends StatefulWidget {
  const InvestRecordScreen({super.key});

  @override
  State<InvestRecordScreen> createState() => _InvestRecordScreenState();
}

class _InvestRecordScreenState extends State<InvestRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final investRecordState = ref.watch(investRecordProvider);
        final List<Datum> investList =
            investRecordState is FetchInvestRecordSuccessState
                ? investRecordState.investRecordHistoryModel!.data
                : [];

        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: GradientAppBar("Invest Record")),
          backgroundColor: KColor.white,
          body: investList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    child: Center(
                      child: Text(
                        " No Record Found",
                        style: KTextStyle.bodyText2
                            .copyWith(color: KColor.black54),
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: investList.length,
                    itemBuilder: (context, index) {
                      // print(orderList[index]);
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4),
                              child: RecordCard(
                                  title: investList[index].product.name,
                                  text: investList[index].createdAt..toString(),
                                  amount: investList[index].price.toString()),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
