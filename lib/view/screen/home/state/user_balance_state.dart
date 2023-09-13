import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/home/model/user_balance_model.dart';

class UserBalanceSuccessState extends SuccessState {
  UserBalanceModel? userBalanceModel;
  UserBalanceSuccessState(this.userBalanceModel);
}
