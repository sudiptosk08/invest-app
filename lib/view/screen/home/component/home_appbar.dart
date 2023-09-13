import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:invest_app/constant/shared_preference_constant.dart";
import "package:invest_app/view/screen/home/component/spin_screen.dart";
import "package:invest_app/view/screen/home/controller/check_daily_spin_controller.dart";
import "package:invest_app/view/screen/home/controller/daily_spin_setting_controller.dart";
import "package:invest_app/view/screen/home/state/check_daily_spin_state.dart";
import "package:invest_app/view/utils/assets/app_assets.dart";
import "package:invest_app/view/utils/styles/k_colors.dart";
import "package:invest_app/view/utils/styles/k_size.dart";
import "package:invest_app/view/utils/styles/k_text_style.dart";
import "package:nb_utils/nb_utils.dart";

class HomeAppBar extends StatelessWidget {
  final double barHeight = 55.0;
  String accessName = getStringAsync(userName);
  String accessUserId = getStringAsync(userId);
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Consumer(builder: (context, ref, child) {
      final checkDailySpinState = ref.watch(checkDailySpinProvider);
      final Object checkSpinModel =
          checkDailySpinState is CheckDailySpinSuccessState
              ? checkDailySpinState.checkDailySpinModel!.data.canSpin
              : "";

      return Container(
        padding: EdgeInsets.only(top: statusbarHeight),
        height: statusbarHeight + barHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            transform: GradientRotation(1),
            end: Alignment.bottomCenter,
            colors: [
              KColor.secondPrimary,
              KColor.primary,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: KSize.getWidth(context, 20),
            right: KSize.getWidth(context, 20),
            top: KSize.getHeight(context, 15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: KSize.getHeight(context, 44),
                    width: KSize.getWidth(context, 44),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(AssetsPath.user),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                      color: KColor.grey200,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accessName,
                        style:
                            KTextStyle.subtitle2.copyWith(color: KColor.white),
                      ),
                      Text(
                        accessUserId,
                        style:
                            KTextStyle.subtitle2.copyWith(color: KColor.white),
                      )
                    ],
                  )
                ],
              ),
              if (checkDailySpinState is CheckDailySpinSuccessState) ...[
                checkSpinModel == true
                    ? GestureDetector(
                        onTap: () {
                          ref.read(spinSettingProvider.notifier).spinSetting();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SpinWheel(),
                              ));
                        },
                        child: Container(
                          height: KSize.getHeight(context, 40),
                          width: KSize.getWidth(context, 60),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: KColor.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              border: Border.all(color: KColor.grey, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Spin",
                                  style: KTextStyle.bodyText3
                                      .copyWith(color: KColor.secondPrimary)),
                            ],
                          ),
                        ),
                      )
                    : Container()
              ]
            ],
          ),
        ),
      );
    });
  }
}
