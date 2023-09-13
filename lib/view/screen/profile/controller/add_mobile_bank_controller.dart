// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/state/add_bank_account_state.dart';
import 'package:invest_app/view/screen/profile/view/page/my_bank_screen.dart';
import 'package:invest_app/view/screen/withdraw/controller/bank_account_list_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../withdraw/controller/mobile_banking_account_list_controller.dart';

/// Providers
final addMobileBankProvider =
    StateNotifierProvider<AddMobileBankController, BaseState>(
  (ref) => AddMobileBankController(ref: ref),
);

/// Controllers
class AddMobileBankController extends StateNotifier<BaseState> {
  final Ref? ref;

  AddMobileBankController({this.ref}) : super(const InitialState());

  Future addMobileBank({
    required String accountId,
    required String accountNumber,
    required String accountType,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'mobile_bank_id': accountId,
      'acc_number': accountNumber,
      'type': accountType,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.addMobileBank, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const AddBankAccuntSuccesState();
        toast("${responseBody['message']}", bgColor: KColor.green);
        print("Add mobile bank Successful");
        ref!
            .read(myMobileBankingListProvider.notifier)
            .fetchMyMobileBankAccount();
        NavigationService.navigateToReplacement(
            CupertinoPageRoute(builder: (context) => const MyBankScreen()));
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
