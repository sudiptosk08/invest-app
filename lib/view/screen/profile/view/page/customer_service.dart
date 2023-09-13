import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  var _chosenCatValue;
  List<String> items = ["Mobile Banking", "Banking"];
  int currentIndex = 0;

  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final settingState = ref.watch(settingProvider);
      Object telegramUrl = settingState is SettingSuccessState
          ? settingState.settingModel!.data.telegramLink
          : "";
      Object whatsappUrl = settingState is SettingSuccessState
          ? settingState.settingModel!.data.whatsappLink
          : "";
      Object email = settingState is SettingSuccessState
          ? settingState.settingModel!.data.email
          : "";

      final Uri telegram = Uri.parse("$telegramUrl");
      final Uri whatsApp = Uri.parse('$whatsappUrl');
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '$email',
      );

      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: GradientAppBar(
              "Customer Service",
            )),
        backgroundColor: KColor.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(
                "Contact With Us",
                textAlign: TextAlign.center,
                style: KTextStyle.subtitle1.copyWith(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(whatsApp);
                      }),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            height: KSize.getHeight(context, 80.5),
                            child: Image.asset("assets/png/whatsapp.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(telegram);
                      }),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            height: KSize.getHeight(context, 80.5),
                            child: Image.asset("assets/png/telegram.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _launched = launchUrl(emailLaunchUri);
                      }),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(0),
                            height: KSize.getHeight(context, 80.5),
                            child: Image.asset(
                              "assets/png/gmail.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    });
  }
}
