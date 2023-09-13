// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:invest_app/view/utils/assets/app_assets.dart';
// import 'package:invest_app/view/utils/extension/extension.dart';
// import 'package:invest_app/view/utils/styles/k_text_style.dart';

// import '../../utils/styles/k_colors.dart';

// class KStepper extends StatefulWidget {
//   final bool checkStepper;

//   const KStepper({required this.checkStepper, Key? key}) : super(key: key);

//   @override
//   State<KStepper> createState() => _KStepperState();
// }

// class _KStepperState extends State<KStepper> {
//   List<String> items = [
//     "4 ",
//     "10 ",
//     "3",
//   ];
//   List<String> description = [
//     "(First tier per person you have get 22.00%)",
//     " (Second tier per person you have get 11.00%)",
//     " (Third tier per person you have get 5.00%)",
//   ];

//   List<String> tier = [
//     "Tier 1",
//     "Tier 2",
//     "Tier 3",
//   ];


//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: items.length,
//       itemBuilder: (BuildContext context, int index) {
//         return InkWell(
//           onTap: () {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 1000),
//             curve: Curves.bounceInOut,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   children: [
//                     _steps(index, context),
//                     _buildSteps(index),
//                   ],
//                 ),
//                 _stepsDescription(index),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Container _steps(int index, BuildContext context) {
//     return Container(
//       //color: Colors.lightBlue,

//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: context.screenWidth * 0.19,
//             child: Text(
//                 textAlign: TextAlign.center,
//                 tier[index],
//                 style:
//                     KTextStyle.subtitle3.copyWith(color: KColor.secondPrimary)),
//           ),
//           Image.asset(
//             tierIcons[index],
//             height: 70,
//           ),
//         ],
//       ),
//     );
//   }

//   Flexible _stepsDescription(int index) {
//     return Flexible(
//         child: Padding(
//             padding: const EdgeInsets.all(22.0),
//             child: RichText(
//               text: TextSpan(
//                 text: items[index],
//                 style: KTextStyle.bodyText3.copyWith(
//                   color: KColor.red,
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: description[index],
//                     style: KTextStyle.bodyText3.copyWith(
//                       color: KColor.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             )));
//   }

//   Column _buildSteps(int index) {
//     return Column(
//       children: [
//         index == items.length - 1
//             ? Container()
//             : SizedBox(
//                 width: 80,
//                 height: 60,
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: DottedLine(
//                     direction: Axis.vertical,
//                     dashLength: 4.0,
//                     dashColor: KColor.grey,
//                     lineThickness: 2,
//                     dashGapLength: 6.0,
//                   ),
//                 ),
//               )
//       ],
//     );
//   }
// }
