import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/screen/profile/controller/get_earning_history_controller.dart';
import 'package:invest_app/view/screen/profile/controller/invest_record_controller.dart';
import 'package:invest_app/view/screen/profile/controller/my_team_controller.dart';
import 'package:invest_app/view/screen/profile/view/page/income_record_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/invest_record_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/my_bank_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/my_team_screen.dart';
import 'package:invest_app/view/screen/withdraw/controller/bank_account_list_controller.dart';
import 'package:invest_app/view/screen/withdraw/controller/mobile_banking_account_list_controller.dart';
import 'package:invest_app/view/utils/assets/app_assets.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:invest_app/view/screen/home/component/category_card.dart';

import '../../../utils/styles/k_colors.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Service",
              style: KTextStyle.subtitle1,
            ),
            Text("View all",
                style:
                    KTextStyle.caption.copyWith(color: KColor.secondPrimary))
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CategoryCard(
            image: AssetsPath.bank,
            title: "My Bank",
            onTap: () {
                   ref
                  .read(mybankAccountListProvider.notifier)
                  .fetchMyBankAccountList();
              ref
                  .read(myMobileBankingListProvider.notifier)
                  .fetchMyMobileBankAccount();
              Navigator.push(context, MaterialPageRoute(builder: ((context) =>const MyBankScreen())));
            },
          ),
          CategoryCard(
            image: AssetsPath.invest,
            title: "Invest Record",
            onTap: () {
               ref.read(investRecordProvider.notifier).fetchInvestRecord();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>const InvestRecordScreen())));
            },
          ),
          CategoryCard(
              image: AssetsPath.team,
              title: "My Team",
              onTap: () {
                 ref.read(myTeamProvider.notifier).myteam();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>const MyTeamScreen())));
              }),
          CategoryCard(
              image: AssetsPath.income,
              title: "Income Record",
              onTap: () {
                ref.read(earningHistoryProvider.notifier).fetchEarningHistory();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>const IncomeRecordScreen())));
              }),
        ])
      ],
    );
  }
}
