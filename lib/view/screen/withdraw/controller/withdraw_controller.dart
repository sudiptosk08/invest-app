// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/withdraw/state/withdraw_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final withdrawProvider = StateNotifierProvider<WithDrawController, BaseState>(
  (ref) => WithDrawController(ref: ref),
);

/// Controllers
class WithDrawController extends StateNotifier<BaseState> {
  final Ref? ref;

  WithDrawController({this.ref}) : super(const InitialState());
  String? bankId;
  String? mobileBankId;
  String? amount;

  Future withdraw() async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'bank_account_id': bankId,
      'mobile_bank_account_id': mobileBankId,
      'amount': amount,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.withDraw, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const WithDrawSuccessState();
        toast("${responseBody['message']}", bgColor: KColor.green);
        print("WithDraw Successful");
        ref!.read(checkUserBalanceProvider.notifier).userBalance();
        
        amount = null;
        bankId = null;
        mobileBankId = null;
        NavigationService.navigateToReplacement(
            CupertinoPageRoute(builder: (context) => const NavigationBarScreen()));
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
