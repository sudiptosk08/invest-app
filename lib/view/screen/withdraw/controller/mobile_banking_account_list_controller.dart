// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/withdraw/model/mobile_banking_list_model.dart';
import 'package:invest_app/view/screen/withdraw/state/mobile_banking_list_state.dart';
//provider

final myMobileBankingListProvider =
    StateNotifierProvider<MyMobileBankAccountListController, BaseState>(
  (ref) => MyMobileBankAccountListController(ref: ref),
);

/// Controllers

class MyMobileBankAccountListController extends StateNotifier<BaseState> {
  final Ref? ref;

  MyMobileBankAccountListController({this.ref}) : super(const InitialState());
  MobileBankingListModel? mobilebankingListModel;

  Future fetchMyMobileBankAccount() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.mymobileBankingAccount),
      );
      if (responseBody != null) {
        mobilebankingListModel = MobileBankingListModel.fromJson(responseBody);
        state = FetchMyMobileBankingSuccessState(mobilebankingListModel);
        print("fetch mobile bank Account state");
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
