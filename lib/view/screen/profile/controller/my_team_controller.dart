// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/profile/model/my_team_model.dart';
import 'package:invest_app/view/screen/profile/state/my_team_state.dart';

/// Providers

final myTeamProvider = StateNotifierProvider<MyTeamController, BaseState>(
  (ref) => MyTeamController(ref: ref),
);

/// Controllers

class MyTeamController extends StateNotifier<BaseState> {
  final Ref? ref;

  MyTeamController({this.ref}) : super(const InitialState());
  MyTeamModel? myTeamModel;

  Future myteam() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.myteam),
      );
      if (responseBody != null) {
        myTeamModel = MyTeamModel.fromJson(responseBody);
        state = MyTeamSuccessState(myTeamModel);
        print("fetch my team state");
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

  Future myteamsearch(String datefrom, String dateto) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(
            API.myteamSearch(dateFrom: datefrom, dateTo: dateto)),
      );
      if (responseBody != null) {
        myTeamModel = MyTeamModel.fromJson(responseBody);
        state = MyTeamSuccessState(myTeamModel);
        print("fetch my team state");
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
