import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_app/view/screen/about/controller/setting_controller.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

class InvitationScreen extends StatefulWidget {
  const InvitationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InvitationScreenState createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  String accessQRCode = getStringAsync(qrCode);
  String accessInvitation = getStringAsync(invitationLink);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final settingState = ref.watch(settingProvider);
        Object settingData = settingState is SettingSuccessState
            ? settingState.settingModel!.data.inviteInstructions
            : "";
        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: GradientAppBar("Invitation ")),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: KSize.getHeight(context, 240),
                        width: KSize.getWidth(context, 220),
                        child: SvgPicture.network(
                          accessQRCode,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: CustomButton(
                            color: KColor.primary,
                            width: double.infinity,
                            height: 45,
                            name: "Copy the link to Invite Firend",
                            textColor: KColor.white,
                            onTap: () {
                              Clipboard.setData(
                                      ClipboardData(text: accessInvitation))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Copied to your clipboard !')));
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(children: [
                    if (settingState is SettingSuccessState) ...[
                      Text(
                        "Invitation Rules.",
                        style: KTextStyle.subtitle1,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          settingData.toString(),
                          textAlign: TextAlign.justify,
                          style: KTextStyle.bodyText3.copyWith(height: 1.2),
                        ),
                      )
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
