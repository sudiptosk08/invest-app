// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/model/invest_record_history_model.dart';
import 'package:invest_app/view/screen/profile/state/invest_record_histroy_state.dart';

/// Providers

final investRecordProvider = StateNotifierProvider<InvestRecordController, BaseState>(
  (ref) => InvestRecordController(ref: ref),
);

/// Controllers

class InvestRecordController extends StateNotifier<BaseState> {
  final Ref? ref;

  InvestRecordController({this.ref}) : super(const InitialState());
  InvestRecordHistoryModel? investRecordHistoryModel;

  Future fetchInvestRecord() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.investRecord),
      );
      if (responseBody != null) {
        investRecordHistoryModel = InvestRecordHistoryModel.fromJson(responseBody);
        state = FetchInvestRecordSuccessState(investRecordHistoryModel);
        print("fetch invest Record state");
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
