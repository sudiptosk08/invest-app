import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/user_profile/model/update_user_model.dart';

class UpdateUserSuccessState extends SuccessState {
  final UpdateUserModel? updateUserModel;

  const UpdateUserSuccessState(this.updateUserModel);
}
