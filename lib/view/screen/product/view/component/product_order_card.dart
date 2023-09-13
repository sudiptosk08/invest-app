import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/product/controller/product_rent_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductCard extends StatelessWidget {
  final bool isChecked;
  final String id;
  final String image;
  final String validity;
  final String productName;
  final String rentalPrice;
  final String dailyIncome;
  final String withdraw;
  final String total_earning;
  final String description;
  const ProductCard(
      {required this.isChecked,
      Key? key,
      required this.id,
      required this.image,
      required this.validity,
      required this.productName,
      required this.rentalPrice,
      required this.dailyIncome,
      required this.withdraw,
      required this.description,
      required this.total_earning})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: KColor.grey.withOpacity(0.5)),
        color: KColor.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              height: KSize.getHeight(context, 230),
              margin:
                  const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(image, scale: 1))),
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: KSize.getWidth(context, 250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: KSize.getHeight(context, 5),
                            ),
                            Text(productName,
                                overflow: TextOverflow.ellipsis,
                                style: KTextStyle.subtitle1),
                            Text("${rentalPrice} Tk",
                                style: KTextStyle.subtitle1),
                          ],
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, _) {
                          final rentState = ref.watch(productRentProvider);
                          return CustomButton(
                            width: KSize.getWidth(context, 90),
                            height: 32,
                            textColor: KColor.white,
                            onTap: () {
                              showConfirmDialogCustom(context,
                                  customCenterWidget: Container(),
                                  subTitle: "Do you want to Rent this Product?",
                                  title: "Confirmation !", onAccept: (p0) {
                                if (rentState is! LoadingState) {
                                  ref
                                      .read(productRentProvider.notifier)
                                      .productRent(id);
                                }
                              },
                                  onCancel: (p0) {},
                                  height: 10,
                                  // dialogType: ,

                                  width: 400,
                                  primaryColor: KColor.primary);
                            },
                            color: KColor.primary,
                            name: "Rent",
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: KSize.getHeight(context, 5),
                  ),
                  text("The product is valid for  ", validity, " days"),
                  text("daily income ≈ ", dailyIncome, " Tk"),
                  text("Interest Rate ", withdraw, " %"),
                  text("Product $validity days to earn ", total_earning, " Tk"),
                  SizedBox(
                    height: 5,
                  ),
                  text(description, "", ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String firstText, String highlightText, String lastText) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        text: firstText,
        style: KTextStyle.bodyText4.copyWith(color: KColor.grey, fontSize: 13),
        children: <TextSpan>[
          TextSpan(
            text: highlightText,
            style: KTextStyle.bodyText4.copyWith(
              color: KColor.red,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: lastText,
            style:
                KTextStyle.bodyText4.copyWith(color: KColor.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
