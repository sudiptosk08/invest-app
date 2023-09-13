// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/home/state/user_balance_state.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_controller.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_history_pagination_controller.dart';
import 'package:invest_app/view/screen/withdraw/view/component/bank_card.dart';
import 'package:invest_app/view/screen/withdraw/view/component/mobile_banking_card.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({
    Key? key,
  }) : super(key: key);

  @override
  _WithDrawScreenState createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  TextEditingController textAmountController = TextEditingController();
  int? selectedAmount;
  List<String> items = ["Mobile Banking", "Banking"];
  int currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userBalanceState = ref.watch(checkUserBalanceProvider);
        final withdrawState = ref.watch(withdrawProvider);
        final settingState = ref.watch(settingProvider);
        int minmumWithDraw = settingState is SettingSuccessState
            ? settingState.settingModel!.data.minimumWithdraw
            : "";

        Object balanceData = userBalanceState is UserBalanceSuccessState
            ? userBalanceState.userBalanceModel!.data.balance
            : "";
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            backgroundColor: KColor.appBackground,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: GradientAppBar("WithDraw ")),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller:
                  ref.read(withdrawHistoryScrollProvider.notifier).controller,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: KSize.getHeight(context, 100),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          transform: GradientRotation(2.089),
                          end: Alignment.bottomCenter,
                          colors: [
                            KColor.secondPrimary,
                            KColor.primary,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: KSize.getHeight(context, 140),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(4, 8), // Shadow position
                          ),
                        ],
                        color: KColor.appBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(KSize.getHeight(context, 4)),
                          topRight: Radius.circular(
                            KSize.getHeight(context, 4),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   AssetsPath.moneybag,
                              //   height: KSize.getHeight(context, 55),
                              //   width: KSize.getWidth(context, 55),
                              // ),
                              Text(
                                balanceData.toString(),
                                style: KTextStyle.headline1,
                              ),
                              Text(
                                "Current Balance",
                                style: KTextStyle.bodyText2
                                    .copyWith(color: KColor.textColorGray),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.all(10),
                                        width: KSize.getWidth(context, 158),
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: index == currentIndex
                                              ? KColor.primary
                                              : KColor.grey400,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            items[index],
                                            style:
                                                KTextStyle.bodyText2.copyWith(
                                              color: index == currentIndex
                                                  ? KColor.white
                                                  : KColor.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          /// MAIN BODY
                          if (currentIndex == 0) const MobileBankingCard(),
                          if (currentIndex == 1) const BankingCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(left: 33.0),
                child: CustomButton(
                    color: KColor.primary,
                    textColor: KColor.white,
                    width: double.infinity,
                    height: 40,
                    name: withdrawState is LoadingState
                        ? "Please Wait"
                        : "Submit",
                    onTap: () {
                      // if (ref.read(withdrawProvider.notifier).amount.toInt() <
                      //     minmumWithDraw) {
                      //   toast("Minimum withdrawal amount is $minmumWithDraw",
                      //       bgColor: KColor.green);
                      // } else {
                        ref.read(withdrawProvider.notifier).withdraw();
                    
                      // }
                    })),
          ),
        );
      },
    );
  }
}
