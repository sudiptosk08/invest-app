import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/profile/controller/my_team_controller.dart';
import 'package:invest_app/view/screen/profile/model/my_team_model.dart';
import 'package:invest_app/view/screen/profile/state/my_team_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  DateTime currentDatefrom = DateTime.now();
  DateTime currentDateto = DateTime.now();

  String? selectedDateForBackendDeveloper;

  datePickerfrom(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: currentDatefrom,
      // firstDate: DateTime(2022),
      //firstDate: DateTime.now(),
      firstDate: DateTime(2023, 1, 1),

      // lastDate: DateTime(3000),

      lastDate: DateTime.now(),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        currentDatefrom = userSelectedDate;
        selectedDateForBackendDeveloper =
            "${currentDatefrom.year}/${currentDatefrom.month}/${currentDatefrom.day}";
        print("Date $selectedDateForBackendDeveloper");
      });
    }
  }

  datePickerto(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: currentDateto,
      // firstDate: DateTime(2022),
      //firstDate: DateTime.now(),
      firstDate: DateTime(2023, 1, 1),

      // lastDate: DateTime(3000),

      lastDate: DateTime.now(),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        currentDateto = userSelectedDate;
        selectedDateForBackendDeveloper =
            "${currentDateto.year}/${currentDateto.month}/${currentDateto.day}";
        print("Date $selectedDateForBackendDeveloper");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: GradientAppBar("My Team")),
      backgroundColor: KColor.white,
      body: Consumer(builder: (context, ref, child) {
        final myTeamState = ref.watch(myTeamProvider);
        final List<Tier1> tier1 = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.tier1
            : [];
        final List<Tier2> tier2 = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.tier2
            : [];
        final List<Tier3> tier3 = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.tier3
            : [];
        final Object description = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.instructions
            : [];
        final Object teamSize = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.teamData.size
            : "";
        final Object totalInvestment = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.teamData.investments
            : "";
        final Object totalRecharge = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.teamData.recharges
            : "";
        final Object totalWithdrawal = myTeamState is MyTeamSuccessState
            ? myTeamState.myTeamModel!.data.teamData.withdraws
            : "";

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(125, 40)),
                          padding: MaterialStateProperty.all(EdgeInsets.all(3)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => KColor.homebuttonBorder)),
                      onPressed: () {
                        datePickerfrom(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentDatefrom.year}/${currentDatefrom.month}/${currentDatefrom.day}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.bodyText3
                                .copyWith(color: KColor.black54),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.date_range,
                            color: KColor.black38,
                          )
                        ],
                      ),
                    ),
                    Text("  to  "),
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(125, 40)),
                          padding: MaterialStateProperty.all(EdgeInsets.all(3)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => KColor.homebuttonBorder)),
                      onPressed: () {
                        datePickerto(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " ${currentDateto.year}/${currentDateto.month}/${currentDateto.day}",
                            style: KTextStyle.bodyText3
                                .copyWith(color: KColor.black54),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.date_range,
                            color: KColor.black38,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: CustomButton(
                          name: "Search",
                          onTap: () {
                            ref.read(myTeamProvider.notifier).myteamsearch(
                                  "${currentDatefrom.year}/${currentDatefrom.month}/${currentDatefrom.day}",
                                  " ${currentDateto.year}/${currentDateto.month}/${currentDateto.day}",
                                );
                          },
                          width: KSize.getWidth(context, 85),
                          height: 40,
                          textColor: KColor.white,
                          color: KColor.primary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 219, 215, 215)),
                                    borderRadius: BorderRadius.circular(4)),
                                width: double.infinity,
                                height: KSize.getHeight(context, 111),
                                child: Column(
                                  children: [
                                    Text(
                                      "Team Size",
                                      style: KTextStyle.headline4,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(teamSize.toString(),
                                        style: KTextStyle.subtitle2
                                            .copyWith(color: KColor.grey400)),
                                  ],
                                ))),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 219, 215, 215)),
                                    borderRadius: BorderRadius.circular(4)),
                                width: double.infinity,
                                height: KSize.getHeight(context, 111),
                                child: Column(
                                  children: [
                                    Text(
                                      "Total Investment",
                                      textAlign: TextAlign.center,
                                      style: KTextStyle.headline4,
                                    ),
                                    Text(totalInvestment.toString(),
                                        style: KTextStyle.subtitle2
                                            .copyWith(color: KColor.grey400)),
                                  ],
                                )))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 219, 215, 215)),
                                    borderRadius: BorderRadius.circular(4)),
                                width: double.infinity,
                                height: KSize.getHeight(context, 111),
                                child: Column(
                                  children: [
                                    Text(
                                      "Team Total Recharge",
                                      textAlign: TextAlign.center,
                                      style: KTextStyle.headline4,
                                    ),
                                    Text(totalRecharge.toString(),
                                        style: KTextStyle.subtitle2
                                            .copyWith(color: KColor.grey400)),
                                  ],
                                ))),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 219, 215, 215)),
                                    borderRadius: BorderRadius.circular(4)),
                                width: double.infinity,
                                height: KSize.getHeight(context, 111),
                                child: Column(
                                  children: [
                                    Text(
                                      "Team Total Withdrawals",
                                      textAlign: TextAlign.center,
                                      style: KTextStyle.headline4,
                                    ),
                                    Text(totalWithdrawal.toString(),
                                        style: KTextStyle.subtitle2
                                            .copyWith(color: KColor.grey400)),
                                  ],
                                )))
                      ],
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 219, 215, 215)),
                      borderRadius: BorderRadius.circular(4)),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tier 1 Users",
                        style: KTextStyle.headline4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (tier1.isEmpty) ...{
                        Text("No available users!",
                            style: KTextStyle.subtitle2
                                .copyWith(color: KColor.grey400)),
                      } else
                        ...List.generate(
                            tier1.length,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(tier1[index].name,
                                                style: KTextStyle.subtitle2
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(
                                              tier1[index].userId,
                                              style: KTextStyle.caption
                                                  .copyWith(color: KColor.grey),
                                            ),
                                          ],
                                        ),
                                        Text(tier1[index].createdAt,
                                            style: KTextStyle.subtitle2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 230, 228, 228),
                                      thickness: 1,
                                    ),
                                  ],
                                ))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 219, 215, 215)),
                      borderRadius: BorderRadius.circular(4)),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tier 2 Users",
                        style: KTextStyle.headline4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (tier2.isEmpty) ...{
                        Text("No available users!",
                            style: KTextStyle.subtitle2
                                .copyWith(color: KColor.grey400)),
                      } else
                        ...List.generate(
                            tier2.length,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(tier2[index].name,
                                                style: KTextStyle.subtitle2
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(
                                              tier2[index].userId,
                                              style: KTextStyle.caption
                                                  .copyWith(color: KColor.grey),
                                            ),
                                          ],
                                        ),
                                        Text(tier2[index].createdAt,
                                            style: KTextStyle.subtitle2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 230, 228, 228),
                                      thickness: 1,
                                    ),
                                  ],
                                ))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 219, 215, 215)),
                      borderRadius: BorderRadius.circular(4)),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tier 3 Users",
                        style: KTextStyle.headline4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (tier3.isEmpty) ...{
                        Text("No available users!",
                            style: KTextStyle.subtitle2
                                .copyWith(color: KColor.grey400)),
                      } else
                        ...List.generate(
                            tier3.length,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(tier3[index].name,
                                                style: KTextStyle.subtitle2
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(
                                              tier3[index].userId,
                                              style: KTextStyle.caption
                                                  .copyWith(color: KColor.grey),
                                            ),
                                          ],
                                        ),
                                        Text(tier3[index].createdAt,
                                            style: KTextStyle.subtitle2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 230, 228, 228),
                                      thickness: 1,
                                    ),
                                  ],
                                ))
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "Instruction",
                    textAlign: TextAlign.center,
                    style: KTextStyle.subtitle1.copyWith(
                      height: 1.2,
                    ),
                  ),
                ),
                Text(
                  description.toString(),
                  textAlign: TextAlign.justify,
                  style: KTextStyle.bodyText3.copyWith(
                    height: 1.2,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
