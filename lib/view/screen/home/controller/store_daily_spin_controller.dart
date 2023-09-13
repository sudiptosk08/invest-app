// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/home/controller/check_daily_spin_controller.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/home/state/store_daily_spin_state.dart';

/// Providers
final storeDailySpinProvider =
    StateNotifierProvider<StoreDailySpinController, BaseState>(
  (ref) => StoreDailySpinController(ref: ref),
);

/// Controllers
class StoreDailySpinController extends StateNotifier<BaseState> {
  final Ref? ref;

  StoreDailySpinController({this.ref}) : super(const InitialState());

  Future storeDailySpin({
    required String amount,
    required String unit,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'amount': amount,
      'unit': unit,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.dailySpinUpdate, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const StoreDailySpinSuccessState();
        print("Store Spin Successful");
        ref!.read(checkDailySpinProvider.notifier).checkDailySpin();
        ref!.read(checkUserBalanceProvider.notifier).userBalance();
        Future.delayed(const Duration(seconds: 6),() {
             NavigationService.navigateToReplacement(CupertinoPageRoute(
                builder: (context) => const NavigationBarScreen()));
        },);
     
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
      print("Error ResponseBody = $responseBody");
    }
  }
}
