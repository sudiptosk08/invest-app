import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/profile/controller/add_bank_account_controller.dart';
import 'package:invest_app/view/screen/profile/controller/add_mobile_bank_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_bankList_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_mobileBankList_controller.dart';
import 'package:invest_app/view/screen/profile/model/get_bank_list_model.dart';
import 'package:invest_app/view/screen/profile/model/get_mobile_bank_list_model.dart';
import 'package:invest_app/view/screen/profile/state/get_bankList_state.dart';
import 'package:invest_app/view/screen/profile/state/get_mobileBankList_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import '../../../../global_component/textformfield/k_text_field.dart';

class AddBankDetailsInfoScreen extends StatefulWidget {
  final String bankingSystem;
  const AddBankDetailsInfoScreen({required this.bankingSystem, super.key});

  @override
  State<AddBankDetailsInfoScreen> createState() =>
      _AddBankDetailsInfoScreenState();
}

class _AddBankDetailsInfoScreenState extends State<AddBankDetailsInfoScreen> {
  var _bankId;
  var _mobileBankId;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  var selectType;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final bankAccountState = ref.watch(getBankListProvider);
        final mobileBankAccountState = ref.watch(getMobileBankListProvider);
        final addBankState = ref.watch(addBankAccountProvider);
        final addMobileBankState = ref.watch(addMobileBankProvider);
        List<BankListDatum> bankaccountList =
            bankAccountState is FetchBankListSuccessState
                ? bankAccountState.getBankListModel!.data
                : [];
        List<MobileBankDatum> mobilebankaccountList =
            mobileBankAccountState is FetchMobileBankListSuccessState
                ? mobileBankAccountState.getMobileBankListModel!.data
                : [];
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: GradientAppBar(widget.bankingSystem == "Bank"
                    ? "Add Bank Info"
                    : "Add Mobile Banking Info")),
            backgroundColor: KColor.white,
            body: widget.bankingSystem == "Bank"
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
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
                                    border: Border.all(
                                        color: KColor.grey.withOpacity(0.6),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(4),
                                    color: KColor.white),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: KSize.getWidth(context, 20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (bankAccountState
                                            is LoadingState) ...{
                                          const Center(
                                              child:
                                                  CupertinoActivityIndicator()),
                                        },
                                        if (bankAccountState
                                            is FetchBankListSuccessState) ...{
                                          DropdownButtonHideUnderline(
                                              child: SizedBox(
                                            height:
                                                KSize.getHeight(context, 50),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              alignment: Alignment.center,
                                              hint: const Text(
                                                  "Select Your Bank"),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              value: _bankId,
                                              // style: TextStyle(color: KColor.primary),
                                              items: bankaccountList.map<
                                                      DropdownMenuItem<String>>(
                                                  (e) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.center,
                                                  value: e.id.toString(),
                                                  child: Text(
                                                    e.name,
                                                    style: KTextStyle.bodyText1
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                KColor.black),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _bankId = value;
                                                });
                                              },
                                            ),
                                          )),
                                        }
                                      ],
                                    ))),
                            KTextField(
                              hintText: 'Enter Your Account Number',
                              labelText: "Account Number",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,
                              isClearableField: true,
                              controller: accountNumberController,
                              requiredField: false,
                              textInputType: TextInputType.number,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                            KTextField(
                              hintText: 'Enter Your Account Name',
                              labelText: "Holder Name",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,

                              isClearableField: true,
                              controller: holderNameController,
                              requiredField: false,
                              textInputType: TextInputType.text,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                            KTextField(
                              hintText: 'Enter Routing Number',
                              labelText: "Routing Number",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,

                              isClearableField: true,
                              controller: routingNumberController,
                              requiredField: false,
                              textInputType: TextInputType.number,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                            KTextField(
                              hintText: 'Enter Branch Name',
                              labelText: "Branch Name",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,

                              isClearableField: true,
                              controller: branchNameController,
                              requiredField: false,
                              textInputType: TextInputType.text,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomButton(
                                color: KColor.primary,
                                textColor: KColor.white,
                                width: double.infinity,
                                height: 40,
                                name: addBankState is! LoadingState
                                    ? "Submit"
                                    : 'Please wait...',
                                onTap: () {
                                  ref
                                      .read(addBankAccountProvider.notifier)
                                      .addbankAccount(
                                          bankId: _bankId,
                                          accountHolderName:
                                              holderNameController.text,
                                          accountNumber:
                                              accountNumberController.text,
                                          branchName: branchNameController.text,
                                          routingNumber:
                                              routingNumberController.text);
                                }),
                          ]),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
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
                                  border: Border.all(
                                      color: KColor.grey.withOpacity(0.6),
                                      width: 1.5),
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
                                      if (mobileBankAccountState
                                          is LoadingState) ...{
                                        const Center(
                                            child:
                                                CupertinoActivityIndicator()),
                                      },
                                      if (mobileBankAccountState
                                          is FetchMobileBankListSuccessState) ...{
                                        DropdownButtonHideUnderline(
                                            child: SizedBox(
                                          height: KSize.getHeight(context, 50),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            alignment: Alignment.center,
                                            hint: const Text(
                                                "Select Your Mobile Banking"),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            value: _mobileBankId,

                                            // style: TextStyle(color: KColor.primary),
                                            items: mobilebankaccountList
                                                .map<DropdownMenuItem<String>>(
                                                    (e) {
                                              return DropdownMenuItem<String>(
                                                alignment: Alignment.center,
                                                value: e.id.toString(),
                                                child: Text(
                                                  e.name,
                                                  style: KTextStyle.bodyText1
                                                      .copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: KColor.black),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _mobileBankId = value;
                                              });
                                            },
                                          ),
                                        )),
                                      }
                                    ],
                                  ))),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
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
                                  border: Border.all(
                                      color: KColor.grey.withOpacity(0.6),
                                      width: 1.5),
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
                                      if (mobileBankAccountState
                                          is LoadingState) ...{
                                        const Center(
                                            child:
                                                CupertinoActivityIndicator()),
                                      },
                                      if (mobileBankAccountState
                                          is FetchMobileBankListSuccessState) ...{
                                        DropdownButtonHideUnderline(
                                            child: SizedBox(
                                          height: KSize.getHeight(context, 50),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            alignment: Alignment.center,
                                            hint: const Text("Account Type"),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            value: selectType,

                                            // style: TextStyle(color: KColor.primary),
                                            items: <String>[
                                              'personal',
                                              'agent',
                                              'merchant',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                alignment: Alignment.center,
                                                value: value,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: KSize.getWidth(
                                                          context, 6.0)),
                                                  child: Text(
                                                    value,
                                                    style: KTextStyle.bodyText1
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                KColor.black),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectType = value;
                                              });
                                            },
                                          ),
                                        )),
                                      }
                                    ],
                                  ))),
                          KTextField(
                            hintText: 'Number',
                            labelText: "Number",
                            hintColor: KColor.grey,
                            hasPrefixIcon: true,

                            isClearableField: true,
                            controller: accountNumberController,
                            requiredField: false,
                            textInputType: TextInputType.number,
                            // validator: (v) => Validators.fieldValidator(v),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          CustomButton(
                              color: KColor.primary,
                              textColor: KColor.white,
                              width: double.infinity,
                              height: 40,
                              name: addMobileBankState is! LoadingState
                                  ? "Submit"
                                  : 'Please wait...',
                              onTap: () {
                                ref
                                    .read(addMobileBankProvider.notifier)
                                    .addMobileBank(
                                        accountId: _mobileBankId,
                                        accountNumber:
                                            accountNumberController.text,
                                        accountType: selectType);
                              }),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
