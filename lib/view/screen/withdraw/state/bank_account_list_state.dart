import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/withdraw/model/bank_account_list_model.dart';

class FetchMyBankAccountListSuccessState extends SuccessState {
  BankAccountListModel? bankAccountListModel;
  FetchMyBankAccountListSuccessState(this.bankAccountListModel);
}
