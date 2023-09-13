// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/model/get_bank_list_model.dart';
import 'package:invest_app/view/screen/profile/state/get_bankList_state.dart';

/// Providers

final getBankListProvider =
    StateNotifierProvider<GetBankListController, BaseState>(
  (ref) => GetBankListController(ref: ref),
);

/// Controllers

class GetBankListController extends StateNotifier<BaseState> {
  final Ref? ref;

  GetBankListController({this.ref}) : super(const InitialState());
  GetBankListModel? getBankListModel;

  Future fetchBankList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.bankList),
      );
      if (responseBody != null) {
        getBankListModel =
            GetBankListModel.fromJson(responseBody);
        state = FetchBankListSuccessState(getBankListModel);
        print("fetch bank List state");
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
