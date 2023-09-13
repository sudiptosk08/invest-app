// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/global_component/service/asset_service.dart';
import 'package:invest_app/view/global_component/textformfield/k_text_field.dart';
import 'package:invest_app/view/screen/recharge/controller/confirm_payment_controller.dart';
import 'package:invest_app/view/screen/recharge/controller/payment_method_controller.dart';
import 'package:invest_app/view/screen/recharge/model/payment_method_model.dart';
import 'package:invest_app/view/screen/recharge/state/confirm_payment_state.dart';
import 'package:invest_app/view/screen/recharge/state/payment_method_state.dart';
import 'package:invest_app/view/utils/extension/extension.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class PaymentConfirmationScreen extends StatefulWidget {
  String transferAmount;
  int id;
  String paymentMethod;
  String img;
  PaymentConfirmationScreen(
      {Key? key,
      required this.paymentMethod,
      required this.transferAmount,
      required this.id,
      required this.img})
      : super(key: key);

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  TextEditingController transIdController = TextEditingController();
  int? selectedAmount;
  XFile? image;
  String currency = getStringAsync(userCurrency);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final paymentState = ref.watch(paymentMethodProvider);
        final confirmPaymentState = ref.watch(confirmPaymentProvider);
        final List<Datum> paymentMethodList =
            paymentState is FetchPaymentSuccessState
                ? paymentState.paymentMethodModel!.data
                : [];
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            backgroundColor: KColor.appBackground,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: GradientAppBar("Confirm Recharge")),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: KSize.getHeight(context, 120),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          transform: GradientRotation(2.089),
                          end: Alignment.bottomCenter,
                          colors: [
                            KColor.secondPrimary,
                            KColor.primary,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        Text(
                          '${widget.transferAmount} $currency',
                          style: KTextStyle.headline4
                              .copyWith(color: KColor.white),
                        ),
                        Text(
                          'Recharge Amount',
                          style: KTextStyle.bodyText2
                              .copyWith(color: KColor.white),
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: KSize.getHeight(context, 240),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(4, 8), // Shadow position
                          ),
                        ],
                        color: KColor.appBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(KSize.getHeight(context, 4)),
                          topRight: Radius.circular(
                            KSize.getHeight(context, 4),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Image.network(
                                        widget.img,
                                        height: KSize.getHeight(context, 60),
                                        width: KSize.getWidth(context, 60),
                                      ),
                                      Text(
                                        widget.paymentMethod,
                                        style: KTextStyle.bodyText1,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //     height: 20,
                                  //     child: VerticalDivider(color: KColor.grey400)),
                                  Text(
                                      paymentMethodList[widget.id]
                                          .accountNumber,
                                      style: KTextStyle.subtitle2.copyWith(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            KTextField(
                              hintText: widget.paymentMethod == "Binance"
                                  ? 'Binance Account Number'
                                  : ' Account Number',
                              labelText: widget.paymentMethod == "Binance"
                                  ? "Binance Account Number"
                                  : " Account Number",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,

                              isClearableField: true,
                              controller: transIdController,
                              requiredField: false,
                              textInputType: TextInputType.phone,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: InkWell(
                      onTap: () async {
                        var pickedfile = await AssetService.pickImageVideo(
                            false, context, ImageSource.gallery);
                        image = pickedfile ?? image;
                        setState(() {});
                      },
                      child: Container(
                        width: context.screenWidth,
                        height: 175,
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: KColor.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Click here to upload image',
                                      style: KTextStyle.bodyText1),
                                ],
                              )
                            : Image.file(
                                File(image!.path),
                                height: 70,
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  Transform.translate(
                      offset: Offset(0, KSize.getHeight(context, -80)),
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                paymentMethodList[widget.id].instruction,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: FullScreenWidget(
                                      disposeLevel: DisposeLevel.High,
                                      backgroundColor: KColor.grey,
                                      backgroundIsTransparent: true,
                                      child: Image.network(
                                        paymentMethodList[widget.id]
                                            .instructionImages[0],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))),
                ],
              ),
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(left: 33.0),
                child: CustomButton(
                    color: KColor.primary,
                    width: double.infinity,
                    textColor: KColor.white,
                    height: 40,
                    name: confirmPaymentState is LoadingState
                        ? "Please wait"
                        : "Confirm",
                    onTap: () {
                      if (transIdController.text.isEmpty) {
                        toast("Input your Transaction Id", bgColor: KColor.red);
                      }
                      print("Payment Method ${widget.id}");
                      if (confirmPaymentState is! ConfirmPaymentSuccessState) {
                        ref
                            .read(confirmPaymentProvider.notifier)
                            .confirmPayment(
                                amount: widget.transferAmount,
                                image: image!.path,
                                paymentMethodId: (widget.id + 1).toString(),
                                transactionId: transIdController.text);
                      }
                    })),
          ),
        );
      },
    );
  }
}
