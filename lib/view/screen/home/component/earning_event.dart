import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/home/controller/all_earning_record_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_earning_history_controller.dart';
import 'package:invest_app/view/screen/profile/model/get_earning_model.dart';
import 'package:invest_app/view/screen/profile/state/get_earning_state.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/styles/k_colors.dart';
import '../../../utils/styles/k_size.dart';
import '../../../utils/styles/k_text_style.dart';

class EarningEvent extends StatefulWidget {
  const EarningEvent({super.key});

  @override
  State<EarningEvent> createState() => _EarningEventState();
}

class _EarningEventState extends State<EarningEvent> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final earninghistroyState = ref.watch(allEarningHistoryProvider);
      final List<EarningDatum> earningrecord =
          earninghistroyState is EarningHistorySuccessState
              ? earninghistroyState.earningHistoryModel!.data
              : [];
      return earninghistroyState is LoadingState
          ? Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 160, 229, 166),
              highlightColor: Colors.white,
              child: Container(
                height: 200,
                color: KColor.grey400,
              ),
            )
          : earningrecord.isEmpty
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Earning Record",
                      style: KTextStyle.subtitle1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: size.width,
                      height: 200,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0), // Shadow position
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
                      child: ListView.builder(
                          // Set itemCount to null for infinite scrolling
                          itemBuilder: (context, index) {
                        final itemIndex = index %
                            earningrecord.length; // Get the index of the item
                        return title(
                          earningrecord[itemIndex].phone,
                          earningrecord[itemIndex].description.toString(),
                          earningrecord[itemIndex].amount.toString(),
                          earningrecord[itemIndex].createdAt.toString(),
                        );
                      }),
                    ),
                  ],
                );
    });
  }

  title(title, String description, String amount, String date) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: KColor.grey.withOpacity(0.3)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.toString(),
                  style: KTextStyle.subtitle2
                      .copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 2,
              ),
              Container(
                width: KSize.getWidth(context, 240),
                child: Text(description,
                    style: KTextStyle.caption, overflow: TextOverflow.clip),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(" $amount",
                  style: KTextStyle.subtitle2
                      .copyWith(fontWeight: FontWeight.w500)),
              Text(date,
                  style: KTextStyle.subtitle2
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
