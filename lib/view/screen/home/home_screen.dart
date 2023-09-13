import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/invite/K_invite_scree.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:invest_app/view/screen/faq/controller/faq_controller.dart';
import 'package:invest_app/view/screen/faq/faq_screen.dart';
import 'package:invest_app/view/screen/home/component/category_card.dart';
import 'package:invest_app/view/screen/home/component/earning_event.dart';
import 'package:invest_app/view/screen/home/component/home_appbar.dart';
import 'package:invest_app/view/screen/home/component/service_category.dart';
import 'package:invest_app/view/screen/home/component/slider_banner.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/home/state/user_balance_state.dart';
import 'package:invest_app/view/screen/profile/view/page/customer_service.dart';
import 'package:invest_app/view/screen/recharge/controller/payment_method_controller.dart';
import 'package:invest_app/view/screen/recharge/controller/recharge_history_controller.dart';
import 'package:invest_app/view/screen/recharge/view/recharges_screen.dart';
import 'package:invest_app/view/screen/withdraw/controller/mobile_banking_account_list_controller.dart';
import 'package:invest_app/view/screen/withdraw/controller/withdraw_history_controller.dart';
import 'package:invest_app/view/screen/withdraw/view/withdraw_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/assets/app_assets.dart';
import '../../utils/styles/k_colors.dart';
import '../../utils/styles/k_size.dart';
import '../../utils/styles/k_text_style.dart';
import '../withdraw/controller/bank_account_list_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String accessInvitation = getStringAsync(invitationLink);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userBalanceState = ref.watch(checkUserBalanceProvider);
        Object balanceData = userBalanceState is UserBalanceSuccessState
            ? userBalanceState.userBalanceModel!.data.balance
            : "";
        Object totalEarningData = userBalanceState is UserBalanceSuccessState
            ? userBalanceState.userBalanceModel!.data.totalEarning
            : "";
        final settingState = ref.watch(settingProvider);

        Object appIcon = settingState is SettingSuccessState
            ? settingState.settingModel!.data.appIcon
            : "";
        print("AppIcons$appIcon");
        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(55), child: HomeAppBar()),
          body: RefreshIndicator(
            onRefresh: () {
              return ref.read(checkUserBalanceProvider.notifier).userBalance();
            },
            child: SafeArea(
              child: SingleChildScrollView(
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
                        height: KSize.getHeight(context, 236),
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
                            topLeft:
                                Radius.circular(KSize.getHeight(context, 4)),
                            topRight: Radius.circular(
                              KSize.getHeight(context, 4),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              settingState is LoadingState
                                  ? Container(
                                      height: 35,
                                      child: CircularProgressIndicator(
                                        color: KColor.primary,
                                      ),
                                    )
                                  : Container(
                                      width: 70,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                appIcon.toString(),
                                              ))),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Total Balance',
                                          style: KTextStyle.bodyText4.copyWith(
                                              color: KColor.textColorGray),
                                        ),
                                        SizedBox(
                                          height: KSize.getHeight(context, 5),
                                        ),
                                        Text(balanceData.toString(),
                                            style: KTextStyle.subtitle1),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                        height: 50,
                                        child: VerticalDivider(
                                            color: KColor.grey400)),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Total earning',
                                          style: KTextStyle.bodyText4.copyWith(
                                              color: KColor.textColorGray),
                                        ),
                                        SizedBox(
                                          height: KSize.getHeight(context, 5),
                                        ),
                                        Text(totalEarningData.toString(),
                                            style: KTextStyle.subtitle1),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: KColor.grey400,
                                height: 30,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CategoryCard(
                                        image: AssetsPath.recharge,
                                        title: "Recharge",
                                        onTap: () {
                                          ref
                                              .read(paymentMethodProvider
                                                  .notifier)
                                              .fetchPaymentMethod();
                                          ref
                                              .read(rechargeHistoryProvider
                                                  .notifier)
                                              .fetchRechargeHistory();

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const RechargesScreen())));
                                        }),
                                    CategoryCard(
                                        image: AssetsPath.withdraw,
                                        title: "Withdrawals",
                                        onTap: () {
                                          ref
                                              .read(mybankAccountListProvider
                                                  .notifier)
                                              .fetchMyBankAccountList();
                                          ref
                                              .read(myMobileBankingListProvider
                                                  .notifier)
                                              .fetchMyMobileBankAccount();

                                          ref
                                              .read(withdrawHistoryProvider
                                                  .notifier)
                                              .fetchWithdrawHistory();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const WithDrawScreen())));
                                        }),
                                    CategoryCard(
                                        image: AssetsPath.customerService,
                                        title: "Service",
                                        onTap: () {
                                          // ref
                                          //     .read(getFaqListProvider.notifier)
                                          //     .fetchFaqList();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const CustomerService())));
                                        }),
                                    CategoryCard(
                                        image: AssetsPath.group,
                                        title: "Invite Firends",
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                                  text: accessInvitation))
                                              .then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Copied to your clipboard !')));
                                          });
                                        }),
                                  ])
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                        offset: Offset(0, KSize.getHeight(context, -100)),
                        child: const Padding(
                            padding: EdgeInsets.all(15), child: Services())),
                    Transform.translate(
                        offset: Offset(0, KSize.getHeight(context, -105)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              width: double.infinity,
                              height: KSize.getHeight(context, 60),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    transform: GradientRotation(1),
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      KColor.secondPrimary,
                                      KColor.primary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Invite Friends to earn rewards",
                                    style: KTextStyle.subtitle1
                                        .copyWith(color: KColor.grey200),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(settingProvider.notifier)
                                          .setting();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InvitationScreen()));
                                    },
                                    child: Container(
                                      height: KSize.getHeight(context, 40),
                                      width: KSize.getWidth(context, 60),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: KColor.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(
                                              color: KColor.grey, width: 1)),
                                      child: Text("Invite",
                                          style: KTextStyle.caption.copyWith(
                                              color: KColor.secondPrimary)),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                    Transform.translate(
                        offset: Offset(0, KSize.getHeight(context, -110)),
                        child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: SliderBanner())),
                    Transform.translate(
                        offset: Offset(0, KSize.getHeight(context, -125)),
                        child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: EarningEvent())),
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
