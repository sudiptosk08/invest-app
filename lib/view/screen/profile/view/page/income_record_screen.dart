import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/profile/controller/earning_history_pagination_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_earning_history_controller.dart';
import 'package:invest_app/view/screen/profile/model/get_earning_model.dart';
import 'package:invest_app/view/screen/profile/state/get_earning_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';

import '../../../../global_component/record_list_card/record_card.dart';

class IncomeRecordScreen extends StatefulWidget {
  const IncomeRecordScreen({super.key});

  @override
  State<IncomeRecordScreen> createState() => _IncomeRecordScreenState();
}

class _IncomeRecordScreenState extends State<IncomeRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: GradientAppBar("Income Record")),
      backgroundColor: KColor.white,
      body: Consumer(builder: (context, ref, _) {
        final earninghistroyState = ref.watch(earningHistoryProvider);
        final List<EarningDatum> earningrecord =
            earninghistroyState is EarningHistorySuccessState
                ? earninghistroyState.earningHistoryModel!.data
                : [];
        return ListView.builder(
          shrinkWrap: true,
          itemCount: earningrecord.length,
          physics: const BouncingScrollPhysics(),
          controller:
              ref.read(earningHistoryScrollProvider.notifier).controller,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // print(orderList[index]);
            return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: RecordCard(
                title: earningrecord[index].description.toString(),
                text: earningrecord[index].createdAt.toString(),
                amount: earningrecord[index].amount.toString(),
              ),
            );
          },
        );
      }),
    );
  }
}

