import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/faq/model/faq_model.dart';

class FetchFaqListSuccessState extends SuccessState {
  FaqModel? getfaqListModel;
  FetchFaqListSuccessState(this.getfaqListModel);
}
