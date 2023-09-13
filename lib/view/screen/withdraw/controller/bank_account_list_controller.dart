// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/withdraw/model/bank_account_list_model.dart';
import 'package:invest_app/view/screen/withdraw/state/bank_account_list_state.dart';

/// Providers

final mybankAccountListProvider =
    StateNotifierProvider<MyBankAccountListController, BaseState>(
  (ref) => MyBankAccountListController(ref: ref),
);

/// Controllers

class MyBankAccountListController extends StateNotifier<BaseState> {
  final Ref? ref;

  MyBankAccountListController({this.ref}) : super(const InitialState());
  BankAccountListModel? bankaccountListModel;

  Future fetchMyBankAccountList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.mybankAccount),
      );
      if (responseBody != null) {
        bankaccountListModel = BankAccountListModel.fromJson(responseBody);
        state = FetchMyBankAccountListSuccessState(bankaccountListModel);
        print("fetch bank Account state");
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
