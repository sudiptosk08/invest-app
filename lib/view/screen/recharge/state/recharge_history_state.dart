import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/recharge/model/recharge_history_model.dart';

class FetchRechargeHistorySuccessState extends SuccessState {
  RechargeHistoryModel? rechargeHistoryModel;
  FetchRechargeHistorySuccessState(this.rechargeHistoryModel);
}
