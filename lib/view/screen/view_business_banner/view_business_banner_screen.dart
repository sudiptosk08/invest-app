import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/view_business_banner/controller/banner_controller.dart';
import 'package:invest_app/view/screen/view_business_banner/model/banner_model.dart';
import 'package:invest_app/view/screen/view_business_banner/state/banner_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';

class ViewBusinessBannerScreen extends StatefulWidget {
  const ViewBusinessBannerScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ViewBusinessBannerScreenState createState() =>
      _ViewBusinessBannerScreenState();
}

class _ViewBusinessBannerScreenState extends State<ViewBusinessBannerScreen> {
  TextEditingController textAmountController = TextEditingController();
  int? selectedAmount;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: GradientAppBar("Banner")),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final bannerState = ref.watch(bannerProvider);
            List<BannerDatum> banner = bannerState is BannerSuccessState
                ? bannerState.bannerModel!.data
                : [];
            return Container(
              child: Carousel(
                boxFit: BoxFit.cover,
                images: banner
                    .map<Widget>(
                      (element) => ClipRRect(
                        child: Image.network(
                          element.image,
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                    .toList(),
                borderRadius: true,
                dotIncreaseSize: 3,
                dotBgColor: Colors.grey.withOpacity(0.0),
                dotSize: 2,
                autoplay: true,
                autoplayDuration: Duration(seconds: 5),
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
