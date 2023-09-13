import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invest_app/constant/logger.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/network_utils.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/auth/login/view/login_screen.dart';
import 'package:invest_app/view/screen/home/controller/all_earning_record_controller.dart';
import 'package:invest_app/view/screen/home/controller/check_daily_spin_controller.dart';
import 'package:invest_app/view/screen/home/controller/user_balance_controller.dart';
import 'package:invest_app/view/screen/profile/controller/get_review_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constant/shared_preference_constant.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initialize();
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);
  var ipAddress;
  var locationResponse;
  @override
  void initState() {
    super.initState();
    ref.read(settingProvider.notifier).setting();
    getIsp();

    checkLogin ? initData() : Container();
  }

  initData() {
    ref.read(getReviewProvider.notifier).fetchReviewList();
    ref.read(checkUserBalanceProvider.notifier).userBalance();
    ref.read(checkDailySpinProvider.notifier).checkDailySpin();
    ref.read(allEarningHistoryProvider.notifier).fetchEarningHistory("all");
  }

  Future getIsp() async {
    var response = await http.get(Uri.parse("https://api.ipify.org/"));
    ipAddress = response.body;
    getLocation();
    print(response.body);
  }

  Future getLocation() async {
    var response =
        await http.get(Uri.parse("http://ip-api.com/json/$ipAddress"));
    locationResponse = json.decode(response.body);
    String countryCode = locationResponse['countryCode'].toString();
    setValue(userPublicLocation, countryCode);
    print("Koi gelay ${response.body}");
  }
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invest App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: checkLogin ? const NavigationBarScreen() : const LoginScreen(),
    );
  }
}
