// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/model/get_reviews_model.dart';
import 'package:invest_app/view/screen/profile/state/get_reviews_state.dart';

/// Providers

final getReviewProvider =
    StateNotifierProvider<GetReviewController, BaseState>(
  (ref) => GetReviewController(ref: ref),
);

/// Controllers

class GetReviewController extends StateNotifier<BaseState> {
  final Ref? ref;

  GetReviewController({this.ref}) : super(const InitialState());
  ReviewModel? reviewModel;

  Future fetchReviewList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getReview),
      );
      if (responseBody != null) {
        reviewModel = ReviewModel.fromJson(responseBody);
        state = ReviewSuccessState(reviewModel);
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
