import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/base_state.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final settingState = ref.watch(settingProvider);
        Object settingData = settingState is SettingSuccessState
            ? settingState.settingModel!.data.about
            : "";
        List<Object> aboutImage = settingState is SettingSuccessState
            ? settingState.settingModel!.data.aboutImages
            : [];
        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: GradientAppBar("About")),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(children: [
                    if (settingState is SettingSuccessState) ...[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          settingData.toString(),
                          textAlign: TextAlign.justify,
                          style: KTextStyle.bodyText3.copyWith(
                            height: 1.2,
                          ),
                        ),
                      ),
                      Container(
                        color: KColor.appBackground,
                        child:  settingState is LoadingState
                                ? Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        255, 160, 229, 166),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: 170,
                                      color: KColor.grey400,
                                    ),
                                  )
                                : aboutImage.isEmpty
                                    ? Container()
                                    : BannerCarousel.fullScreen(
                                        onTap: (index) {},
                                        // banners: bannerList,
                                        customizedIndicators:
                                            const IndicatorModel.animation(
                                          width: 8,
                                          height: 8,
                                          spaceBetween: 4,
                                          widthAnimation: 30,
                                        ),
                                        customizedBanners: [
                                          ...List.generate(
                                              aboutImage.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Image.network(
                                                              aboutImage[index]
                                                                  .toString(),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                        ],
                                        height: 200,
                                        borderRadius: 10,
                                        activeColor: KColor.grey,
                                        animation: true,
                                        initialPage: 0,
                                      )
                          
                      ),
                    ]
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
