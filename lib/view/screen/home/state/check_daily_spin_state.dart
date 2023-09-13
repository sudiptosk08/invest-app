import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/home/model/check_daily_spin_model.dart';

class CheckDailySpinSuccessState extends SuccessState {
  DailySpinCheckModel? checkDailySpinModel;
  CheckDailySpinSuccessState(this.checkDailySpinModel);
}
