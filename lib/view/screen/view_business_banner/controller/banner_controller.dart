// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/view_business_banner/model/banner_model.dart';
import 'package:invest_app/view/screen/view_business_banner/state/banner_state.dart';

/// Providers

final bannerProvider = StateNotifierProvider<BannerController, BaseState>(
  (ref) => BannerController(ref: ref),
);

/// Controllers

class BannerController extends StateNotifier<BaseState> {
  final Ref? ref;

  BannerController({this.ref}) : super(const InitialState());
  BannerModel? bannermodel;

  Future banner() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.banner),
      );
      if (responseBody != null) {
        bannermodel = BannerModel.fromJson(responseBody);
        state = BannerSuccessState(bannermodel);
        print("fetch banner state");
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
