// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/state/add_bank_account_state.dart';
import 'package:invest_app/view/screen/profile/view/page/my_bank_screen.dart';
import 'package:invest_app/view/screen/withdraw/controller/mobile_banking_account_list_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../withdraw/controller/bank_account_list_controller.dart';

/// Providers
final addBankAccountProvider =
    StateNotifierProvider<AddBankAccountController, BaseState>(
  (ref) => AddBankAccountController(ref: ref),
);

/// Controllers
class AddBankAccountController extends StateNotifier<BaseState> {
  final Ref? ref;

  AddBankAccountController({this.ref}) : super(const InitialState());

  Future addbankAccount({
    required String bankId,
    required String accountHolderName,
    required String accountNumber,
    required String branchName,
    required String routingNumber,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'bank_id': bankId,
      'acc_holder_name': accountHolderName,
      'acc_number': accountNumber,
      'branch_name': branchName,
      'routing_number': routingNumber
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.addbankAccount, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const AddBankAccuntSuccesState();
        toast("${responseBody['message']}", bgColor: KColor.green);
        print("Add bank Successful");
        ref!.read(mybankAccountListProvider.notifier).fetchMyBankAccountList();

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
