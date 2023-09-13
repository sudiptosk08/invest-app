// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/about/model/setting_model.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers

final settingProvider = StateNotifierProvider<SettingController, BaseState>(
  (ref) => SettingController(ref: ref),
);

/// Controllers

class SettingController extends StateNotifier<BaseState> {
  final Ref? ref;
  SettingController({this.ref}) : super(const InitialState());
  SettingModel? settingModel;

  Future setting() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.getRequest(API.setting);
      if (responseBody != null) {
        final response = json.decode(responseBody.body);
        settingModel = SettingModel.fromJson(response);
        setValue(userCurrency, settingModel!.data.currency);

        state = SettingSuccessState(settingModel);
        print("fetch settings state");
        print("$response");
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
