import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/profile/model/get_bank_list_model.dart';

class FetchBankListSuccessState extends SuccessState {
  GetBankListModel? getBankListModel;
  FetchBankListSuccessState(this.getBankListModel);
}
