// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/faq/model/faq_model.dart';
import 'package:invest_app/view/screen/faq/state/faq_state.dart';

/// Providers

final getFaqListProvider =
    StateNotifierProvider<GetFaqListController, BaseState>(
  (ref) => GetFaqListController(ref: ref),
);

/// Controllers

class GetFaqListController extends StateNotifier<BaseState> {
  final Ref? ref;

  GetFaqListController({this.ref}) : super(const InitialState());
  FaqModel? faqModel;

  Future fetchFaqList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.faqs),
      );
      if (responseBody != null) {
        faqModel = FaqModel.fromJson(responseBody);
        state = FetchFaqListSuccessState(faqModel);
        print("fetch faq List state");
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
