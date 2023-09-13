// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/controller/earning_history_pagination_controller.dart';
import 'package:invest_app/view/screen/profile/model/get_earning_model.dart';
import 'package:invest_app/view/screen/profile/state/get_earning_state.dart';


/// Providers
final earningHistoryProvider =
    StateNotifierProvider<EarningHistoryController, BaseState>(
  (ref) => EarningHistoryController(ref: ref),
);

/// Controllers
class EarningHistoryController extends StateNotifier<BaseState> {
  final Ref? ref;

  EarningHistoryController({this.ref}) : super(const InitialState());
  EarningHistoryModel? earningHistoryModel;
  int? lastpage;

  int page = 1;
  Future fetchEarningHistory() async {
    state = const LoadingState();

    dynamic responseBody;
    //for filter page value

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.earningHistory()),
      );

      if (responseBody != null) {
        earningHistoryModel = EarningHistoryModel.fromJson(responseBody);
        lastpage = earningHistoryModel!.meta.lastPage;
        page = earningHistoryModel!.meta.currentPage;
        state = EarningHistorySuccessState(earningHistoryModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  Future fetchMoreEarningHistory() async {
    if (earningHistoryModel == null) state = const LoadingState();

    var responseBody;
    //for filter page value
    if (lastpage == page) {
      return null;
    } else {
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.earningHistory(
            page: page += 1,
          )),
        );
        if (responseBody != null) {
          var earningHistoryNewModel =
              EarningHistoryModel.fromJson(responseBody);
          earningHistoryModel!.data.addAll(earningHistoryNewModel.data);
          earningHistoryModel!.meta.currentPage =
              earningHistoryNewModel.meta.currentPage;
          earningHistoryModel!.meta.lastPage =
              earningHistoryNewModel.meta.lastPage;

          state = EarningHistorySuccessState(earningHistoryModel);
          ref!.read(earningHistoryScrollProvider.notifier).resetState();
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
