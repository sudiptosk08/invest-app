

import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/auth/login/model/user_model.dart';

class LoginSuccessState extends SuccessState {
  final UserModel? userModel;

  const LoginSuccessState(this.userModel);
}
