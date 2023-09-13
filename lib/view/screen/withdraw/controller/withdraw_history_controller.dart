// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_history_pagination_controller.dart';
import 'package:invest_app/view/screen/withdraw/model/withdraw_history_model.dart';
import 'package:invest_app/view/screen/withdraw/state/withdraw_history_state.dart';

/// Providers
final withdrawHistoryProvider =
    StateNotifierProvider<WithdrawHistoryController, BaseState>(
  (ref) => WithdrawHistoryController(ref: ref),
);

/// Controllers
class WithdrawHistoryController extends StateNotifier<BaseState> {
  final Ref? ref;

  WithdrawHistoryController({this.ref}) : super(const InitialState());
  WithdrawHistoryModel? withdrawHistoryModel;
  int? lastpage;

  int page = 1;
  Future fetchWithdrawHistory() async {
    state = const LoadingState();

    dynamic responseBody;
    //for filter page value

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.withdrawHistory()),
      );

      if (responseBody != null) {
        withdrawHistoryModel = WithdrawHistoryModel.fromJson(responseBody);
        page = withdrawHistoryModel!.meta.currentPage;
        lastpage = withdrawHistoryModel!.meta.lastPage;
        state = WithdrawHistorySuccessState(withdrawHistoryModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  Future fetchMoreWithdrawHistory() async {
    if (withdrawHistoryModel == null) state = const LoadingState();

    var responseBody;
    //for filter page value
    if (lastpage == page) {
      return null;
    } else {
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.withdrawHistory(
            page: page += 1,
          )),
        );
        if (responseBody != null) {
          var withdrawNewHistoryNewModel =
              WithdrawHistoryModel.fromJson(responseBody);
          withdrawHistoryModel!.data.addAll(withdrawNewHistoryNewModel.data);
          withdrawHistoryModel!.meta.currentPage =
              withdrawNewHistoryNewModel.meta.currentPage;
          withdrawHistoryModel!.meta.lastPage =
              withdrawNewHistoryNewModel.meta.lastPage;

          state = WithdrawHistorySuccessState(withdrawHistoryModel);
          ref!.read(withdrawHistoryScrollProvider.notifier).resetState();
        } else {
          state = const ErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = const ErrorState();
      }
    }
  }
}
