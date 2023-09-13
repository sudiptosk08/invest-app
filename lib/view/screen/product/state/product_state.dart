import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/product/model/product_model.dart';

class FetchProductSuccessState extends SuccessState {
  ProductModel? productModel;
  FetchProductSuccessState(this.productModel);
}
