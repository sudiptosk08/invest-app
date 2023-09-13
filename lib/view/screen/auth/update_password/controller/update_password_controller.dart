// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/auth/update_password/state/password_update_state.dart';
import 'package:invest_app/view/screen/user_profile/model/update_user_model.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final passwordUpdateProvider =
    StateNotifierProvider<PasswordUpdateController, BaseState>(
  (ref) => PasswordUpdateController(ref: ref),
);

/// Controllers
class PasswordUpdateController extends StateNotifier<BaseState> {
  final Ref? ref;

  PasswordUpdateController({this.ref}) : super(const InitialState());
  UpdateUserModel? updateUserModel;

  Future updatePassword({
    required String oldPass,
    required String newPass,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'old_password': oldPass,
      'new_password': newPass,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.updatepassword, requestBody),
      );
      if (responseBody != null) {
       

        state =const PasswordUpdateSuccessState();
        toast("${responseBody['message']}", bgColor: KColor.green);
      
     
        NavigationService.navigateToReplacement(
          CupertinoPageRoute(
            builder: (context) => const NavigationBarScreen(),
          ),
        );
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
