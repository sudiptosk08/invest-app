import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/profile/controller/get_bankList_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_mobileBankList_controller.dart';
import 'package:invest_app/view/screen/profile/view/page/add_bank_info_screen.dart';
import 'package:invest_app/view/screen/profile/view/tab/bank_tab.dart';
import 'package:invest_app/view/screen/profile/view/tab/mobile_banking_tab.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

class MyBankScreen extends StatefulWidget {
  const MyBankScreen({super.key});

  @override
  State<MyBankScreen> createState() => _MyBankScreenState();
}

class _MyBankScreenState extends State<MyBankScreen> {
  var _chosenCatValue;
  List<String> items = ["Mobile Banking", "Banking"];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: GradientAppBar(
            "My Bank",
          )),
      backgroundColor: KColor.white,
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 80,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(10),
                            width: KSize.getWidth(context, 167),
                            height: 40,
                            decoration: BoxDecoration(
                              color: index == currentIndex
                                  ? KColor.primary
                                  : KColor.grey400,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: KTextStyle.bodyText2.copyWith(
                                  color: index == currentIndex
                                      ? KColor.white
                                      : KColor.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              /// MAIN BODY
              if (currentIndex == 0) const MobileBankingListCard(),
              if (currentIndex == 1) const BankListCard(),
            ],
          ),
        ]),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return Padding(
              padding: const EdgeInsets.only(left: 29, bottom: 10),
              child: InkWell(
                onTap: () {
                  currentIndex == 0
                      ? ref
                          .read(getMobileBankListProvider.notifier)
                          .fetchMobileBankList()
                      : ref.read(getBankListProvider.notifier).fetchBankList();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => currentIndex == 0
                              ? const AddBankDetailsInfoScreen(
                                  bankingSystem: "Mobile Bank",
                                )
                              : const AddBankDetailsInfoScreen(
                                  bankingSystem: "Bank",
                                ))));
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: KColor.primary,
                      boxShadow: [
                        BoxShadow(
                            color: KColor.grey.withOpacity(0.4),
                            blurRadius: 1,
                            spreadRadius: 0,
                            offset: const Offset(1, 1))
                      ],
                      border: Border.all(color: KColor.grey, width: 1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Text(
                      currentIndex == 0 ? " Add Mobile Bank" : "Add Bank",
                      style: KTextStyle.bodyText2.copyWith(color: KColor.white),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
