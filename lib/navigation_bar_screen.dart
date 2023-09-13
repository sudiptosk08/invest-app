// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/home/home_screen.dart';
import 'package:invest_app/view/screen/product/controller/products_controller.dart';
import 'package:invest_app/view/screen/view_business_banner/controller/banner_controller.dart';
import 'package:invest_app/view/screen/view_business_banner/view_business_banner_screen.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

import 'view/screen/about/about_screen.dart';
import 'view/screen/product/view/product_list_screen.dart';
import 'view/screen/profile/view/profile_screen.dart';

class NavigationBarScreen extends ConsumerStatefulWidget {
  const NavigationBarScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends ConsumerState<NavigationBarScreen> {
  var token;
  var user;
  @override
  void initState() {
    super.initState();
  }

  Widget currentScreen =const HomeScreen();

  int currentTab = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    ProductScreen(),
    ViewBusinessBannerScreen(),
    AboutScreen(),
    ProfileScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KColor.white,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        // floatingActionButton: FloatingActionBottom(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          color: KColor.white,
          child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomeScreen();
                        currentTab = 0;
                        // store.state.logoutUserData = null;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_home_outlined,
                            size: 25,
                            color:
                                currentTab == 0 ? KColor.primary : KColor.grey),
                        Text(
                          "Home",
                          style: KTextStyle.caption.copyWith(
                            color:
                                currentTab == 0 ? KColor.primary : KColor.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProductScreen();
                        ref.read(productProvider.notifier).fetchProducts();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category_outlined,
                            size: 25,
                            color:
                                currentTab == 1 ? KColor.primary : KColor.grey),
                        Text(
                          "Product",
                          style: KTextStyle.caption.copyWith(
                            color:
                                currentTab == 1 ? KColor.primary : KColor.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        ref.read(bannerProvider.notifier).banner();
                        currentScreen = const ViewBusinessBannerScreen();
                        currentTab = 2;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                          color: KColor.black, shape: BoxShape.circle),
                      child: Icon(Icons.qr_code_2_outlined,
                          size: 25,
                          color:
                              currentTab == 2 ? KColor.primary : KColor.white),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = const AboutScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.document_scanner_outlined,
                            size: 25,
                            color:
                                currentTab == 3 ? KColor.primary : KColor.grey),
                        Text(
                          "About",
                          style: KTextStyle.caption.copyWith(
                            color:
                                currentTab == 3 ? KColor.primary : KColor.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfileScreen();

                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_3_outlined,
                            size: 25,
                            color:
                                currentTab == 4 ? KColor.primary : KColor.grey),
                        Text(
                          "Profile",
                          style: KTextStyle.caption.copyWith(
                            color:
                                currentTab == 4 ? KColor.primary : KColor.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
