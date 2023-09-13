// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/recharge/controller/recharge_history_controller.dart';
import 'package:invest_app/view/screen/recharge/model/recharge_history_model.dart';
import 'package:invest_app/view/screen/recharge/state/recharge_history_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../constant/shared_preference_constant.dart';

class RechargeRecordList extends StatefulWidget {
  RechargeRecordList({super.key});

  @override
  State<RechargeRecordList> createState() => _RechargeRecordListState();
}

class _RechargeRecordListState extends State<RechargeRecordList> {
  var _chosenCatValue; // category
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String currency = getStringAsync(userCurrency);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final rechargehistroyState = ref.watch(rechargeHistoryProvider);
      final List<RechargeHistoryDatum> withdrawrecord =
          rechargehistroyState is FetchRechargeHistorySuccessState
              ? rechargehistroyState.rechargeHistoryModel!.data
              : [];

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (rechargehistroyState is LoadingState) ...[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Loading ...",
                  style: KTextStyle.bodyText3.copyWith(color: KColor.grey),
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
        if (rechargehistroyState is FetchRechargeHistorySuccessState) ...[
          if (withdrawrecord.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: KColor.grey),
                    color: KColor.white,
                    boxShadow: [
                      BoxShadow(
                          color: KColor.grey.withOpacity(0.4),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(1, 1)),
                    ],
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Text(
                    " No Record Found",
                    style: KTextStyle.bodyText2.copyWith(color: KColor.black54),
                  ),
                ),
              ),
            )
          else
            ...List.generate(
                withdrawrecord.length,
                (index) => card(
                    withdrawrecord[index].paymentMethod,
                    withdrawrecord[index].createdAt.toString(),
                    withdrawrecord[index].amount.toString(),
                    withdrawrecord[index].status)),
        ]
      ]);
    });
  }

  Widget card(String title, String time, String amount, String status) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: KColor.grey.withOpacity(0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: KTextStyle.subtitle2
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 2,
              ),
              Text(time, style: KTextStyle.caption),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("$status  ",
                  style: KTextStyle.caption.copyWith(color: KColor.primary)),
              const SizedBox(
                height: 2,
              ),
              Text(
                "$amount $currency",
                style:
                    KTextStyle.subtitle2.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
