
// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/product/model/product_model.dart';
import 'package:invest_app/view/screen/product/state/product_state.dart';

/// Providers

final productProvider = StateNotifierProvider<ProductController, BaseState>(
  (ref) => ProductController(ref: ref),
);

/// Controllers

class ProductController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProductController({this.ref}) : super(const InitialState());
 ProductModel? productModel;
  

  Future fetchProducts() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.products),
      );
      if (responseBody != null) {
        productModel = ProductModel.fromJson(responseBody);
        state = FetchProductSuccessState(productModel);
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
