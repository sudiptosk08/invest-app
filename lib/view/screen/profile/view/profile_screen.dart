import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/auth/logout/controller/log_out_controller.dart';
import 'package:invest_app/view/screen/auth/update_password/update_password.dart';
import 'package:invest_app/view/screen/profile/controller/get_earning_history_controller.dart';
import 'package:invest_app/view/screen/profile/controller/invest_record_controller.dart';
import 'package:invest_app/view/screen/profile/controller/my_team_controller.dart';
import 'package:invest_app/view/screen/profile/view/page/customer_service.dart';
import 'package:invest_app/view/screen/user_profile/edit_profile_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/income_record_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/invest_record_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/my_bank_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/my_team_screen.dart';
import 'package:invest_app/view/screen/profile/view/page/review_add_screen.dart';
import 'package:invest_app/view/screen/withdraw/controller/bank_account_list_controller.dart';
import 'package:invest_app/view/screen/withdraw/controller/mobile_banking_account_list_controller.dart';
import 'package:invest_app/view/utils/assets/app_assets.dart';

import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

import 'component/profile_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  TextEditingController textAmountController = TextEditingController();
  int? selectedAmount;
  int currentIndex = 0;
  String accessName = getStringAsync(userName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: GradientAppBar("Profile")),
      body: SingleChildScrollView(
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
                height: KSize.getHeight(context, 110),
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
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: KSize.getHeight(context, 44),
                                    width: KSize.getWidth(context, 44),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(AssetsPath.user),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                      color: KColor.grey200,
                                    ),
                                  ),
                                  Text(
                                    accessName,
                                    style: KTextStyle.subtitle1,
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const EditProfileScreen())));
                                  },
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, KSize.getHeight(context, -80)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileCategoryCard(
                        image: AssetsPath.bank,
                        title: "My Bank",
                        onTap: () {
                          ref
                              .read(mybankAccountListProvider.notifier)
                              .fetchMyBankAccountList();
                          ref
                              .read(myMobileBankingListProvider.notifier)
                              .fetchMyMobileBankAccount();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const MyBankScreen())));
                        },
                      ),
                      ProfileCategoryCard(
                        image: AssetsPath.invest,
                        title: "Invest Record",
                        onTap: () {
                          ref
                              .read(investRecordProvider.notifier)
                              .fetchInvestRecord();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const InvestRecordScreen())));
                        },
                      ),
                      ProfileCategoryCard(
                          image: AssetsPath.team,
                          title: "My Team",
                          onTap: () {
                            ref.read(myTeamProvider.notifier).myteam();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const MyTeamScreen())));
                          }),
                      ProfileCategoryCard(
                          image: AssetsPath.income,
                          title: "Income Record",
                          onTap: () {
                            ref
                                .read(earningHistoryProvider.notifier)
                                .fetchEarningHistory();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const IncomeRecordScreen())));
                          }),
                      ProfileCategoryCard(
                          image: AssetsPath.password,
                          title: "Change Password",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const UpdatePasswordScreen())));
                          }),
                      ProfileCategoryCard(
                          image: AssetsPath.review,
                          title: "Add Review",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const AddReviewsScreen())));
                          }),
                      // ProfileCategoryCard(
                      //     image: AssetsPath.customerService,
                      //     title: "Customer Service",
                      //     onTap: () {
                          
                      //     }),
                      ProfileCategoryCard(
                          image: AssetsPath.logout,
                          title: "Logout",
                          onTap: () {
                            ref.read(logoutProvider.notifier).logout();
                          }),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
