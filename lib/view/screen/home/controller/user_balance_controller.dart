// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/home/model/user_balance_model.dart';
import 'package:invest_app/view/screen/home/state/user_balance_state.dart';

/// Providers

final checkUserBalanceProvider =
    StateNotifierProvider<UserBalanceController, BaseState>(
  (ref) => UserBalanceController(ref: ref),
);

/// Controllers

class UserBalanceController extends StateNotifier<BaseState> {
  final Ref? ref;

  UserBalanceController({this.ref}) : super(const InitialState());
  UserBalanceModel? userBalanceModel;

  Future userBalance() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.userBalance),
      );
      if (responseBody != null) {
        userBalanceModel = UserBalanceModel.fromJson(responseBody);
        state = UserBalanceSuccessState(userBalanceModel);
        print("fetch balance state");
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
