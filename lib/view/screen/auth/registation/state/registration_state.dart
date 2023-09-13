import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/auth/login/model/user_model.dart';

class SignupSuccessState extends SuccessState {
  final UserModel? userModel;

  SignupSuccessState(this.userModel);
}
