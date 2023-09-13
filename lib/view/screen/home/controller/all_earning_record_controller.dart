// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/model/get_earning_model.dart';
import 'package:invest_app/view/screen/profile/state/get_earning_state.dart';


/// Providers
final allEarningHistoryProvider =
    StateNotifierProvider<AllEarningHistoryController, BaseState>(
  (ref) => AllEarningHistoryController(ref: ref),
);

/// Controllers
class AllEarningHistoryController extends StateNotifier<BaseState> {
  final Ref? ref;

  AllEarningHistoryController({this.ref}) : super(const InitialState());
  EarningHistoryModel? earningHistoryModel;
  int? lastpage;

  int page = 1;
  Future fetchEarningHistory(type) async {
    state = const LoadingState();

    dynamic responseBody;
    //for filter page value

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.earningHistory(type: type,)),
      );

      if (responseBody != null) {
        earningHistoryModel = EarningHistoryModel.fromJson(responseBody);
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
}
