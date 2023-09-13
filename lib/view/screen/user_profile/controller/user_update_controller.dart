// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/user_profile/model/update_user_model.dart';
import 'package:invest_app/view/screen/user_profile/state/update_user_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final updateUserProvider =
    StateNotifierProvider<UserUpdateController, BaseState>(
  (ref) => UserUpdateController(ref: ref),
);

/// Controllers
class UserUpdateController extends StateNotifier<BaseState> {
  final Ref? ref;

  UserUpdateController({this.ref}) : super(const InitialState());
  UpdateUserModel? updateUserModel;

  Future updateUser({
    required String phone,
    required String name,
    required String code,
    required String dialCode,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'country_code': code,
      'phone_code': dialCode,
      'phone': phone,
      'name': name,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.updateUser, requestBody),
      );
      if (responseBody != null) {
        updateUserModel = UpdateUserModel.fromJson(responseBody);

        state = UpdateUserSuccessState(updateUserModel);
        toast("${responseBody['message']}", bgColor: KColor.green);
        // setValue(isLoggedIn, true);
        // setValue(token, userModel!.data.token);
        // setValue(rememberToken, userModel!.data.token);
        setValue(userId, updateUserModel!.data.userId);
        setValue(userName, updateUserModel!.data.name);
        setValue(userContact, updateUserModel!.data.phone);
        setValue(qrCode, updateUserModel!.data.qrCode);
        setValue(invitationLink, updateUserModel!.data.inviteLink);
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
