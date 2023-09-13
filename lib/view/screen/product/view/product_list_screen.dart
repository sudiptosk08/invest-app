import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/product/controller/products_controller.dart';
import 'package:invest_app/view/screen/product/model/product_model.dart';
import 'package:invest_app/view/screen/product/state/product_state.dart';
import 'package:invest_app/view/screen/product/view/component/product_order_card.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final productState = ref.watch(productProvider);
        final List<Datum> productList = productState is FetchProductSuccessState
            ? productState.productModel!.data
            : [];
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: GradientAppBar("Product")),
          backgroundColor: KColor.white,
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                // print(orderList[index]);
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      if (productState is LoadingState) ...[
                        const Center(
                          child: CircularProgressIndicator(
                            color: KColor.black,
                            strokeWidth: 1,
                          ),
                        )
                      ],
                      if (productState is FetchProductSuccessState) ...[
                        productList.isEmpty
                            ? const Center(child: Text("no order found"))
                            : ProductCard(
                                isChecked: true,
                                image: productList[index].image.toString(),
                                id: productList[index].id.toString(),
                                validity:
                                    productList[index].validity.toString(),
                                productName: productList[index].name,
                                rentalPrice:
                                    productList[index].price.toString(),
                                dailyIncome:
                                    productList[index].dailyIncome.toString(),
                                withdraw:
                                    productList[index].minWithdraw.toString(),
                                total_earning:
                                    productList[index].totalEarning.toString(),
                                description:
                                    productList[index].description.toString(),
                              ),
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
