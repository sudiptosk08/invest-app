import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/profile/model/get_earning_model.dart';

class EarningHistorySuccessState extends SuccessState {
  EarningHistoryModel? earningHistoryModel;
  EarningHistorySuccessState(this.earningHistoryModel);
}
