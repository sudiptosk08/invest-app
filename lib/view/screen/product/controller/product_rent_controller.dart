// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/product/state/product_rent_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final productRentProvider =
    StateNotifierProvider<ProductRentController, BaseState>(
  (ref) => ProductRentController(ref: ref),
);

/// Controllers
class ProductRentController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProductRentController({this.ref}) : super(const InitialState());

  Future productRent(String id) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {};
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.productRent(id: id), requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const ProductRentSuccessState();
        toast("${responseBody['message']}", bgColor: KColor.green);
        print("Product Rent SuccessFull");
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
      print("Error ResponseBody = $responseBody");
    }
  }
}
