// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/recharge/model/payment_method_model.dart';
import 'package:invest_app/view/screen/recharge/state/payment_method_state.dart';

/// Providers

final paymentMethodProvider = StateNotifierProvider<PaymentMethodController, BaseState>(
  (ref) => PaymentMethodController(ref: ref),
);

/// Controllers

class PaymentMethodController extends StateNotifier<BaseState> {
  final Ref? ref;

  PaymentMethodController({this.ref}) : super(const InitialState());
  PaymentMethodModel? paymentMethodModel;

  Future fetchPaymentMethod() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.paymentMethod),
      );
      if (responseBody != null) {
        paymentMethodModel = PaymentMethodModel.fromJson(responseBody);
        state = FetchPaymentSuccessState(paymentMethodModel);
        print("fetch product state");
        print("$responseBody");
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}
