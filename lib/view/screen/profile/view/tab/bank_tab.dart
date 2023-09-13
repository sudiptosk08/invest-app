import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/record_list_card/record_card.dart';
import 'package:invest_app/view/screen/withdraw/controller/bank_account_list_controller.dart';
import 'package:invest_app/view/screen/withdraw/model/bank_account_list_model.dart';
import 'package:invest_app/view/screen/withdraw/state/bank_account_list_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

class BankListCard extends StatefulWidget {
  const BankListCard({super.key});

  @override
  State<BankListCard> createState() => _BankListCardState();
}

class _BankListCardState extends State<BankListCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final bankAccountState = ref.watch(mybankAccountListProvider);
      List<MyBankAccountData> bankaccountList =
          bankAccountState is FetchMyBankAccountListSuccessState
              ? bankAccountState.bankAccountListModel!.data
              : [];
      return bankaccountList.isEmpty
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
                itemCount: bankaccountList.length,
                itemBuilder: (context, index) {
                  // print(orderList[index]);
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        if (bankAccountState is LoadingState) ...[
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
                        if (bankAccountState
                            is FetchMyBankAccountListSuccessState) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: RecordCard(
                                title: bankaccountList[index].bankName,
                                text:
                                    "Card Num:${bankaccountList[index].accNumber}",
                                amount: bankaccountList[index].routingNumber),
                          ),
                        ]
                      ],
                    ),
                  );
                },
              ),
            );
    });
  }
}
