// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/home/model/daily_spin_setting_model.dart';
import 'package:invest_app/view/screen/home/state/daily_spin_setting_state.dart';

/// Providers

final spinSettingProvider =
    StateNotifierProvider<SpinSettingController, BaseState>(
  (ref) => SpinSettingController(ref: ref),
);

/// Controllers

class SpinSettingController extends StateNotifier<BaseState> {
  final Ref? ref;

  SpinSettingController({this.ref}) : super(const InitialState());
  SpinSettingModel? spinSettingModel;

  Future spinSetting() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.spinSetting),
      );
      if (responseBody != null) {
        spinSettingModel = SpinSettingModel.fromJson(responseBody);
        state = SpinSettingSuccessState(spinSettingModel);
        print("fetch spin Settings state");
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
