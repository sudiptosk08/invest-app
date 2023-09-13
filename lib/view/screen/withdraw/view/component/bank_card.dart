// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/textformfield/k_text_field.dart';
import 'package:invest_app/view/screen/profile/controller/get_bankList_controller.dart';
import 'package:invest_app/view/screen/profile/view/page/add_bank_info_screen.dart';
import 'package:invest_app/view/screen/withdraw/controller/bank_account_list_controller.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_controller.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_history_controller.dart';
import 'package:invest_app/view/screen/withdraw/model/bank_account_list_model.dart';
import 'package:invest_app/view/screen/withdraw/model/withdraw_history_model.dart';
import 'package:invest_app/view/screen/withdraw/state/bank_account_list_state.dart';
import 'package:invest_app/view/screen/withdraw/state/withdraw_history_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

class BankingCard extends StatefulWidget {
  const BankingCard({super.key});

  @override
  State<BankingCard> createState() => _BankingCardState();
}

class _BankingCardState extends State<BankingCard> {
  var _chosenCatValue;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String currency = getStringAsync(userCurrency);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final bankAccountState = ref.watch(mybankAccountListProvider);
        List<MyBankAccountData> bankaccountList =
            bankAccountState is FetchMyBankAccountListSuccessState
                ? bankAccountState.bankAccountListModel!.data
                : [];
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    ref.read(getBankListProvider.notifier).fetchBankList();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const AddBankDetailsInfoScreen(
                                  bankingSystem: "Bank",
                                ))));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: KColor.grey),
                        color: KColor.white,
                        boxShadow: [
                          BoxShadow(
                              color: KColor.grey.withOpacity(0.4),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: const Offset(1, 1)),
                        ],
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        " Add  Bank",
                        style: KTextStyle.bodyText2
                            .copyWith(color: KColor.black54),
                      ),
                    ),
                  ),
                )),
            bankaccountList.isEmpty
                ? SizedBox(
                    child: Text(
                      "You have not added any bank accounts yet.Click Add Bank to continue",
                      textAlign: TextAlign.center,
                      style: KTextStyle.bodyText4,
                    ),
                  )
                : Container(
                    height: KSize.getHeight(context, 55.5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: KColor.grey.withOpacity(0.4),
                              blurRadius: 1,
                              spreadRadius: 0,
                              offset: const Offset(1, 1))
                        ],
                        border: Border.all(color: KColor.grey, width: 1),
                        borderRadius: BorderRadius.circular(4),
                        color: KColor.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: KSize.getWidth(context, 20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (bankAccountState is LoadingState) ...{
                            const Center(child: CupertinoActivityIndicator()),
                          },
                          if (bankAccountState
                              is FetchMyBankAccountListSuccessState) ...{
                            DropdownButtonHideUnderline(
                                child: SizedBox(
                              height: KSize.getHeight(context, 50),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                alignment: Alignment.center,
                                hint: const Text("Select Your Bank"),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                value: _chosenCatValue,
                                //elevation: 5,
                                // style: TextStyle(color: KColor.primary),
                                items: bankaccountList
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: e.id.toString(),
                                    child: Text(
                                      e.bankName,
                                      style: KTextStyle.bodyText1.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: KColor.black),
                                    ),
                                  );
                                }).toList(),

                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenCatValue = value;
                                    print("Alkasjdlf $_chosenCatValue");
                                    ref.read(withdrawProvider.notifier).bankId =
                                        _chosenCatValue;
                                  });
                                },
                              ),
                            ))
                          }
                        ],
                      ),
                    ),
                  ),
            KTextField(
              hintText: 'Amount',
              labelText: " Amount",
              hintColor: KColor.grey,
              hasPrefixIcon: true,
              callBack: true,
              callBackFunction: (value) {
                ref.read(withdrawProvider.notifier).amount = value;
              },
              isClearableField: true,
              controller: amountController,
              requiredField: false,
              textInputType: TextInputType.phone,
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (context, ref, _) {
              final withdrawhistroyState = ref.watch(withdrawHistoryProvider);
              final List<WithdrawDatum> withdrawrecord =
                  withdrawhistroyState is WithdrawHistorySuccessState
                      ? withdrawhistroyState.withdrawHistoryModel!.data
                      : [];

              List<String> bankAccountTimes = [];
              List<String> bankAccountNums = [];

              for (int i = 0; i < withdrawrecord.length; i++) {
                if (withdrawrecord[i].mobileBankAccountId == 0) {
                  var bankAccountName =
                      withdrawrecord[i].bankAccount!.createdAt;
                  bankAccountTimes.add(bankAccountName.toString());
                }
              }
              for (int i = 0; i < withdrawrecord.length; i++) {
                if (withdrawrecord[i].mobileBankAccountId == 0) {
                  var bankAccountNum = withdrawrecord[i].bankAccount!.accNumber;
                  bankAccountNums.add(bankAccountNum.toString());
                }
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bank WithDraw Record",
                      style: KTextStyle.subtitle1,
                    ),
                    if (withdrawhistroyState is LoadingState) ...[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Loading ...",
                              style: KTextStyle.bodyText3
                                  .copyWith(color: KColor.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircularProgressIndicator(
                              color: KColor.primary,
                            )
                          ],
                        ),
                      ),
                    ],
                    if (withdrawhistroyState
                        is WithdrawHistorySuccessState) ...[
                      if (bankAccountTimes.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                border: Border.all(color: KColor.grey),
                                color: KColor.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: KColor.grey.withOpacity(0.4),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: const Offset(1, 1)),
                                ],
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                " No Record Found",
                                style: KTextStyle.bodyText2
                                    .copyWith(color: KColor.black54),
                              ),
                            ),
                          ),
                        )
                      else
                        ...List.generate(
                            bankAccountTimes.length,
                            (index) => card(
                                  bankAccountNums[index],
                                  bankAccountTimes[index],
                                  withdrawrecord[index].amount.toString(),
                                  withdrawrecord[index].status.toString(),
                                )),
                    ]
                  ]);
            })
          ],
        );
      },
    );
  }

  Widget card(String title, String time, String amount, String status) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: KColor.grey.withOpacity(0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: KTextStyle.subtitle2
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 2,
              ),
              Text(time, style: KTextStyle.caption),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$amount $currency",
                style:
                    KTextStyle.subtitle2.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              Text("$status ",
                  style: KTextStyle.caption.copyWith(color: KColor.primary)),
            ],
          ),
        ],
      ),
    );
  }
}
