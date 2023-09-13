// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/recharge/controller/recharge_history_pagination_controller.dart';
import 'package:invest_app/view/screen/recharge/model/recharge_history_model.dart';
import 'package:invest_app/view/screen/recharge/state/recharge_history_state.dart';
/// Providers
final rechargeHistoryProvider =
    StateNotifierProvider<RechargeHistoryController, BaseState>(
  (ref) => RechargeHistoryController(ref: ref),
);

/// Controllers
class RechargeHistoryController extends StateNotifier<BaseState> {
  final Ref? ref;

  RechargeHistoryController({this.ref}) : super(const InitialState());
  RechargeHistoryModel? rechargeHistoryModel;
  int? lastpage;

  int page = 1;
  Future fetchRechargeHistory() async {
    state = const LoadingState();

    dynamic responseBody;
    //for filter page value

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.rechargeHistory()),
      );

      if (responseBody != null) {
        rechargeHistoryModel = RechargeHistoryModel.fromJson(responseBody);
        page = rechargeHistoryModel!.meta.currentPage;
        lastpage = rechargeHistoryModel!.meta.lastPage;
        state = FetchRechargeHistorySuccessState(rechargeHistoryModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  Future fetchMoreRechargeHistory() async {
    if (rechargeHistoryModel == null) state = const LoadingState();

    var responseBody;
    //for filter page value
    if (lastpage == page) {
      return null;
    } else {
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.rechargeHistory(
            page: page += 1,
          )),
        );
        if (responseBody != null) {
          var rechargeHistoryNewModel =
              RechargeHistoryModel.fromJson(responseBody);
          rechargeHistoryModel!.data.addAll(rechargeHistoryNewModel.data);
          rechargeHistoryModel!.meta.currentPage =
              rechargeHistoryNewModel.meta.currentPage;
          rechargeHistoryModel!.meta.lastPage =
              rechargeHistoryNewModel.meta.lastPage;

          state = FetchRechargeHistorySuccessState(rechargeHistoryModel);
          ref!.read(rechargeHistoryScrollProvider.notifier).resetState();
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
