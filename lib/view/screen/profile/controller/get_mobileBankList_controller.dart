// ignore_for_file: avoid_print, file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/model/get_mobile_bank_list_model.dart';
import 'package:invest_app/view/screen/profile/state/get_mobileBankList_state.dart';

/// Providers

final getMobileBankListProvider =
    StateNotifierProvider<GetMobileBankListController, BaseState>(
  (ref) => GetMobileBankListController(ref: ref),
);

/// Controllers

class GetMobileBankListController extends StateNotifier<BaseState> {
  final Ref? ref;

  GetMobileBankListController({this.ref}) : super(const InitialState());
  GetMobileBankListModel? getMobileBankListModel;

  Future fetchMobileBankList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.mobileBankingList),
      );
      if (responseBody != null) {
        getMobileBankListModel = GetMobileBankListModel.fromJson(responseBody);
        state = FetchMobileBankListSuccessState(getMobileBankListModel);
        print("fetch Mobile bank List state");
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
