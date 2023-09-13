import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/withdraw/model/withdraw_history_model.dart';

class WithdrawHistorySuccessState extends SuccessState {
  WithdrawHistoryModel? withdrawHistoryModel;
  WithdrawHistorySuccessState(this.withdrawHistoryModel);
}
