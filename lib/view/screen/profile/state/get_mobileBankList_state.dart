import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/profile/model/get_mobile_bank_list_model.dart';

class FetchMobileBankListSuccessState extends SuccessState {
  GetMobileBankListModel? getMobileBankListModel;
  FetchMobileBankListSuccessState(this.getMobileBankListModel);
}
