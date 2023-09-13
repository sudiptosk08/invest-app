// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/home/model/check_daily_spin_model.dart';
import 'package:invest_app/view/screen/home/state/check_daily_spin_state.dart';

/// Providers

final checkDailySpinProvider =
    StateNotifierProvider<CheckDailySpinController, BaseState>(
  (ref) => CheckDailySpinController(ref: ref),
);

/// Controllers

class CheckDailySpinController extends StateNotifier<BaseState> {
  final Ref? ref;

  CheckDailySpinController({this.ref}) : super(const InitialState());
  DailySpinCheckModel? dailySpinCheckModel;

  Future checkDailySpin() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.dailySpinCheck),
      );
      if (responseBody != null) {
        dailySpinCheckModel = DailySpinCheckModel.fromJson(responseBody);
        state = CheckDailySpinSuccessState(dailySpinCheckModel);
        print("fetch check daily spin state");
        print("$responseBody");
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}
