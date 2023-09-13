import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/home/controller/daily_spin_setting_controller.dart';
import 'package:invest_app/view/screen/home/controller/store_daily_spin_controller.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/home/state/daily_spin_setting_state.dart';
import 'package:invest_app/view/screen/home/state/user_balance_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:rxdart/subjects.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  bool startSpin = false;
  int rewards = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final spinSettingsState = ref.watch(spinSettingProvider);
        final storeDailySpinState = ref.watch(storeDailySpinProvider);
        final List<Object> spinSettingList =
            spinSettingsState is SpinSettingSuccessState
                ? spinSettingsState.spinSettingModel!.data.amounts
                : [];
        final Object spinSettingModel =
            spinSettingsState is SpinSettingSuccessState
                ? spinSettingsState.spinSettingModel!.data.unit
                : [];
        final userBalanceState = ref.watch(checkUserBalanceProvider);
        Object balanceData = userBalanceState is UserBalanceSuccessState
            ? userBalanceState.userBalanceModel!.data.balance
            : "";
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (spinSettingsState is LoadingState) ...[
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
              if (spinSettingsState is SpinSettingSuccessState) ...[
                Text(
                  "Balance:$balanceData",
                  style: KTextStyle.headline5,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 300,
                  child: FortuneWheel(
                    selected: selected.stream,
                    animateFirst: false,
                    indicators: [
                      FortuneIndicator(
                        alignment: Alignment
                            .topCenter, // <-- changing the position of the indicator
                        child: TriangleIndicator(
                          color: Colors.orange.withOpacity(
                              0.5), // <-- changing the color of the indicator
                        ),
                      ),
                    ],
                    items: [
                      for (int i = 0;
                          i < spinSettingList.length;
                          i++) ...<FortuneItem>{
                        FortuneItem(
                            child: Text(
                                "${spinSettingList[i].toString()} $spinSettingModel")),
                      },
                    ],
                    onAnimationEnd: () {
                      setState(() {
                        rewards = int.parse(
                            spinSettingList[selected.value].toString());
                        balanceData =
                            (int.parse(balanceData.toString()) + rewards)
                                .toString();
                        startSpin = true;
                      });
                      print(rewards);
                      if (storeDailySpinState is! LoadingState) {
                        ref
                            .read(storeDailySpinProvider.notifier)
                            .storeDailySpin(
                              amount: rewards.toString(),
                              unit: spinSettingModel.toString(),
                            );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.fixed,
                          duration: const Duration(seconds: 5),
                          content:
                              Text("You just won $rewards $spinSettingModel!"),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: CustomButton(
                    color: KColor.primary,
                    textColor: KColor.white,
                    width: double.infinity,
                    height: 40,
                    name: "Start",
                    onTap: () {
                      setState(() {
                        startSpin == false
                            ? selected.add(
                                Fortune.randomInt(0, spinSettingList.length))
                            : null;
                      });
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
