import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/global_component/textformfield/k_text_field.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/home/state/user_balance_state.dart';
import 'package:invest_app/view/screen/recharge/controller/payment_method_controller.dart';
import 'package:invest_app/view/screen/recharge/controller/recharge_history_controller.dart';
import 'package:invest_app/view/screen/recharge/controller/recharge_history_pagination_controller.dart';
import 'package:invest_app/view/screen/recharge/model/recharge_history_model.dart';
import 'package:invest_app/view/screen/recharge/page/recharge_confirmation_screen.dart';
import 'package:invest_app/view/screen/recharge/state/recharge_history_state.dart';
import 'package:invest_app/view/screen/recharge/view/component/recharge_record_card_list.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/recharge/model/payment_method_model.dart';
import 'package:invest_app/view/screen/recharge/state/payment_method_state.dart';
import 'package:nb_utils/nb_utils.dart';

class RechargesScreen extends StatefulWidget {
  const RechargesScreen({super.key});

  @override
  State<RechargesScreen> createState() => _RechargesScreenState();
}

class _RechargesScreenState extends State<RechargesScreen> {
  TextEditingController textAmountController = TextEditingController();
  int? selectedAmount;
  var selectedPaymentMethod;
  var image;
  var paymentMethod;
  var id;
  List<String> items = ["Recharge"];
  int currentIndex = 0;
  List categories = [
    {
      'id': 0,
      'name': '1000',
    },
    {
      'id': 1,
      'name': '2000',
    },
    {
      'id': 2,
      'name': '3000',
    },
    {
      'id': 3,
      'name': '5000',
    },
    {
      'id': 4,
      'name': '7000',
    },
    {
      'id': 5,
      'name': '9000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userBalanceState = ref.watch(checkUserBalanceProvider);
        Object balanceData = userBalanceState is UserBalanceSuccessState
            ? userBalanceState.userBalanceModel!.data.balance
            : "";
        final rechargehistroyState = ref.watch(rechargeHistoryProvider);
        final List<RechargeHistoryDatum> rechargerecord =
            rechargehistroyState is FetchRechargeHistorySuccessState
                ? rechargehistroyState.rechargeHistoryModel!.data
                : [];
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            backgroundColor: KColor.appBackground,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: GradientAppBar("Recharge ")),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller:
                  ref.read(rechargeHistoryScrollProvider.notifier).controller,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: KSize.getHeight(context, 100),
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
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: KSize.getHeight(context, 161),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Balance',
                                  style: KTextStyle.bodyText4
                                      .copyWith(color: KColor.textColorGray),
                                ),
                                Text(balanceData.toString(),
                                    style: KTextStyle.subtitle1),
                              ],
                            ),
                            Divider(
                              color: KColor.grey400,
                              height: 25,
                            ),
                            Text("Choose", style: KTextStyle.subtitle1),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    child: Wrap(
                                      spacing: 10,
                                      children: List.generate(
                                        categories.length,
                                        (index) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedAmount = index;
                                              textAmountController.text =
                                                  categories[index]['name'];
                                            });
                                          },
                                          child: Chip(
                                            backgroundColor: selectedAmount ==
                                                    categories[index]['id']
                                                ? KColor.primary
                                                : KColor.white,
                                            side: BorderSide(
                                              color: selectedAmount ==
                                                      categories[index]['id']
                                                  ? const Color(0xff81C2B8)
                                                  : KColor.grey,
                                            ),
                                            label: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 0,
                                              ),
                                              child: Text(
                                                categories[index]['name'],
                                                style: selectedAmount ==
                                                        categories[index]['id']
                                                    ? KTextStyle.subtitle1
                                                        .copyWith(
                                                            color: KColor.white)
                                                    : KTextStyle.subtitle3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: KTextField(
                        hintText: 'Recharge Amount',
                        labelText: "\$ Amount",
                        hintColor: KColor.grey,
                        hasPrefixIcon: true,
                        isClearableField: true,
                        controller: textAmountController,
                        requiredField: false,
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, KSize.getHeight(context, -80)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recharge Record",
                              style: KTextStyle.subtitle1,
                            ),

                            /// MAIN BODY
                            RechargeRecordList(),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Consumer(builder: (context, ref, _) {
              final paymentState = ref.watch(paymentMethodProvider);
              final List<Datum> paymentMethodList =
                  paymentState is FetchPaymentSuccessState
                      ? paymentState.paymentMethodModel!.data
                      : [];
              return Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: CustomButton(
                  color: KColor.primary,
                  textColor: KColor.white,
                  height: 40,
                  name: "Continue",
                  onTap: () {
                    textAmountController.text == "" ||
                            textAmountController.text.toInt() < 100
                        ? toast("Minimum recharge amount 100 tk",
                            bgColor: KColor.red)
                        : paymentState is LoadingState
                            ? const CircularProgressIndicator()
                            : showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context, setState) {
                                    return Container(
                                      height: KSize.getHeight(context, 295),
                                      decoration: const BoxDecoration(
                                          color: KColor.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height:
                                                  KSize.getHeight(context, 8)),

                                          Text(
                                            'Choose Payment Method',
                                            style: KTextStyle.subtitle1
                                                .copyWith(color: KColor.black),
                                          ),

                                          /// Task Type List
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ...List.generate(
                                                  paymentMethodList.length,
                                                  (index) {
                                                return Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 2,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: KColor.grey200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Image.network(
                                                          paymentMethodList[
                                                                  index]
                                                              .icon,
                                                          height:
                                                              KSize.getHeight(
                                                                  context, 45),
                                                          width: KSize.getWidth(
                                                              context, 45),
                                                        ),
                                                      ),
                                                      Text(
                                                        paymentMethodList[index]
                                                            .name,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Radio(
                                                        value:
                                                            paymentMethodList[
                                                                    index]
                                                                .id,
                                                        groupValue:
                                                            selectedPaymentMethod,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedPaymentMethod =
                                                                paymentMethodList[
                                                                        index]
                                                                    .id;
                                                            image =
                                                                paymentMethodList[
                                                                        index]
                                                                    .icon;
                                                            paymentMethod =
                                                                paymentMethodList[
                                                                        index]
                                                                    .name;
                                                            id = index;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),

                                          /// Button

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    KSize.getWidth(context, 16),
                                                vertical: 12),
                                            child: CustomButton(
                                              name: "Continue",
                                              textColor: KColor.white,
                                              onTap: () {
                                                id == null
                                                    ? toast(
                                                        "Select Your Payment Method",
                                                        bgColor: KColor.red)
                                                    : Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                PaymentConfirmationScreen(
                                                                  img: image,
                                                                  id: id,
                                                                  paymentMethod:
                                                                      paymentMethod,
                                                                  transferAmount:
                                                                      textAmountController
                                                                          .text,
                                                                ))));
                                              },
                                              color: KColor.primary,
                                              height: 40,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                });
                  },
                  width: double.infinity,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
