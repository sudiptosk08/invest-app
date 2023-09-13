import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/profile/controller/get_review_controller.dart';
import 'package:invest_app/view/screen/profile/model/get_reviews_model.dart';
import 'package:invest_app/view/screen/profile/state/get_reviews_state.dart';
import 'package:invest_app/view/screen/profile/view/page/review_add_screen.dart';
import 'package:invest_app/view/utils/assets/app_assets.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:shimmer/shimmer.dart';

class SliderBanner extends StatefulWidget {
  const SliderBanner({super.key});

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  int pageSliders = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final reviewState = ref.watch(getReviewProvider);
        final List<RiviewsDatum>? reviewData = reviewState is ReviewSuccessState
            ? reviewState.reviewModel?.data
            : [];
        List<BannerModel> bannerList = reviewData!
            .map(
              (entry) => BannerModel(
                  imagePath: entry.image,
                  id: entry.userId,
                  boxFit: BoxFit.fill),
            )
            .toList();

        return Container(
          color: KColor.appBackground,
          child: pageSliders == 1
              ? reviewState is LoadingState
                  ? Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 160, 229, 166),
                      highlightColor: Colors.white,
                      child: Container(
                        height: 170,
                        color: KColor.grey400,
                      ),
                    )
                  : reviewData.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const AddReviewsScreen())));
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            color: KColor.primary.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                "Add Review Section",
                                style: KTextStyle.headline4
                                    .copyWith(color: KColor.white),
                              ),
                            ),
                          ),
                        )
                      : BannerCarousel.fullScreen(
                          onTap: (index) {},
                          // banners: bannerList,
                          customizedIndicators: const IndicatorModel.animation(
                            width: 8,
                            height: 8,
                            spaceBetween: 4,
                            widthAnimation: 30,
                          ),
                          customizedBanners: [
                            ...List.generate(
                                reviewData.length,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Image.network(
                                                reviewData[index].image,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(reviewData[index].msg)),
                                      ],
                                    ))
                          ],
                          height: 200,
                          borderRadius: 10,
                          activeColor: KColor.grey,
                          animation: true,
                          initialPage: 0,
                        )
              : BannerCarousel(
                  banners: BannerImages.listProducts,
                  customizedIndicators: const IndicatorModel.animation(
                    width: 8,
                    height: 8,
                    spaceBetween: 4,
                    widthAnimation: 30,
                  ),
                  width: 203,
                  height: 80,
                  activeColor: KColor.grey,
                  animation: true,
                  initialPage: 0,
                ),
        );
      },
    );
  }
}

class BannerImages {
  static List<BannerModel> listProducts = [
    BannerModel(
        imagePath: AssetsPath.company, id: "1", boxFit: BoxFit.fitHeight),
  ];
}
