import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/record_list_card/record_card.dart';
import 'package:invest_app/view/screen/withdraw/model/mobile_banking_list_model.dart';
import 'package:invest_app/view/screen/withdraw/state/mobile_banking_list_state.dart';

import '../../../../utils/styles/k_colors.dart';
import '../../../../utils/styles/k_text_style.dart';
import '../../../withdraw/controller/mobile_banking_account_list_controller.dart';

class MobileBankingListCard extends StatefulWidget {
  const MobileBankingListCard({super.key});

  @override
  State<MobileBankingListCard> createState() => _MobileBankingListCardState();
}

class _MobileBankingListCardState extends State<MobileBankingListCard> {
  var _chosenCatValue; // category

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final mobileBankAccountState = ref.watch(myMobileBankingListProvider);
      List<MyMobileBankData> mobilebankaccountList =
          mobileBankAccountState is FetchMyMobileBankingSuccessState
              ? mobileBankAccountState.mobilebankingListModel!.data
              : [];

      return mobilebankaccountList.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                height: 120,
                child: Center(
                  child: Text(
                    " No Record Found",
                    style: KTextStyle.bodyText2.copyWith(color: KColor.black54),
                  ),
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: mobilebankaccountList.length,
                itemBuilder: (context, index) {
                  // print(orderList[index]);
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        if (mobileBankAccountState is LoadingState) ...[
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Loading ...",
                                  style: KTextStyle.bodyText3
                                      .copyWith(color: KColor.grey),
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
                        if (mobileBankAccountState
                            is FetchMyMobileBankingSuccessState) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: RecordCard(
                                title: mobilebankaccountList[index].accNumber,
                                text:
                                    mobilebankaccountList[index].mobileBankName,
                                amount: mobilebankaccountList[index].type),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ));
    });
  }
}
