// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/auth/login/model/user_model.dart';
import 'package:invest_app/view/screen/auth/login/state/login_state.dart';
import 'package:invest_app/view/screen/auth/login/view/login_screen.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final logoutProvider = StateNotifierProvider<LogoutController, BaseState>(
  (ref) => LogoutController(ref: ref),
);

/// Controllers
class LogoutController extends StateNotifier<BaseState> {
  final Ref? ref;

  LogoutController({this.ref}) : super(const InitialState());
  UserModel? userModel;

  Future logout() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.getRequest(API.logout);
      if (responseBody != null) {
        setValue(isLoggedIn, false);
        setValue(token, null);
        setValue(rememberToken, null);

        setValue(userId, null);
        setValue(userName, null);
        setValue(userContact, null);
        setValue(qrCode, null);
        setValue(invitationLink, null);

        var userData;
        state = LoginSuccessState(userData);
        toast("Logout", bgColor: KColor.green);

        NavigationService.navigateToReplacement(
          CupertinoPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
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
