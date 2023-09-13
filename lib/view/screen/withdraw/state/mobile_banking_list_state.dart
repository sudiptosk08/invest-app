import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/withdraw/model/mobile_banking_list_model.dart';

class FetchMyMobileBankingSuccessState extends SuccessState {
  MobileBankingListModel? mobilebankingListModel;
  FetchMyMobileBankingSuccessState(this.mobilebankingListModel);
}
