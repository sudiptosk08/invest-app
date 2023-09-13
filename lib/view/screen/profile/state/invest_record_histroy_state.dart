import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/profile/model/invest_record_history_model.dart';

class FetchInvestRecordSuccessState extends SuccessState {
  InvestRecordHistoryModel? investRecordHistoryModel;
  FetchInvestRecordSuccessState(this.investRecordHistoryModel);
}
