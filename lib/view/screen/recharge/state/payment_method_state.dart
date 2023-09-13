import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/recharge/model/payment_method_model.dart';

class FetchPaymentSuccessState extends SuccessState {
  PaymentMethodModel? paymentMethodModel;
  FetchPaymentSuccessState(this.paymentMethodModel);
}
