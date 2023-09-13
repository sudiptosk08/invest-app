// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/auth/login/model/user_model.dart';
import 'package:invest_app/view/screen/auth/registation/state/registration_state.dart';
import 'package:invest_app/view/screen/home/controller/all_earning_record_controller.dart';
import 'package:invest_app/view/screen/home/controller/check_daily_spin_controller.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_review_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../about/controller/setting_controller.dart';

/// Providers
final signupProvider = StateNotifierProvider<SignupController, BaseState>(
  (ref) => SignupController(ref: ref),
);

/// Controllers
class SignupController extends StateNotifier<BaseState> {
  final Ref? ref;

  SignupController({this.ref}) : super(const InitialState());
  UserModel? userModel;

  Future register({
    required String countryCode,
    required String phone,
    required String password,
    required String name,
    required String dialCode,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'country_code': countryCode,
      'phone_code': dialCode,
      'name': name,
      'phone': phone,
      'password': password,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.signup, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        if (responseBody['data']['token'] != null) {
          userModel = UserModel.fromJson(responseBody);

          state = SignupSuccessState(userModel);

          toast("${responseBody['message']}", bgColor: KColor.green);
          setValue(isLoggedIn, true);
          setValue(token, userModel!.data.token);
          setValue(rememberToken, userModel!.data.token);
          setValue(userId, userModel!.data.user.userId);
          setValue(userName, userModel!.data.user.name);
          setValue(userContact, userModel!.data.user.phone);
          setValue(qrCode, userModel!.data.user.qrCode);
          setValue(dialCountryCode, userModel!.data.user.phoneCode);
          setValue(countryFlagCode, userModel!.data.user.countryCode);
          setValue(invitationLink, userModel!.data.user.inviteLink);
          ref!.read(checkDailySpinProvider.notifier).checkDailySpin();
          ref!.read(checkUserBalanceProvider.notifier).userBalance();
          ref!.read(getReviewProvider.notifier).fetchReviewList();
          ref!
              .read(allEarningHistoryProvider.notifier)
              .fetchEarningHistory("all");
          NavigationService.navigateToReplacement(
            CupertinoPageRoute(
              builder: (context) => const NavigationBarScreen(),
            ),
          );
        }
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
      print("Error ResponseBody = $responseBody");
    }
  }
}
