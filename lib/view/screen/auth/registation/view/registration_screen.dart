// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/about/state/setting_state.dart';
import 'package:invest_app/view/screen/auth/login/view/login_screen.dart';
import 'package:invest_app/view/screen/auth/registation/controller/registration_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../global_component/textformfield/k_text_field.dart';
import '../../../about/controller/setting_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var dialCode;
  var countryCode;
  bool border = false;

  bool continueLogin = false;
  String userLocation = getStringAsync(userPublicLocation);
  dynamic allowedCountries;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final settingState = ref.watch(settingProvider);

      allowedCountries = settingState is SettingSuccessState
          ? settingState.settingModel!.data.allowedCountries
          : "";

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          backgroundColor: KColor.appBackground,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: KSize.getHeight(context, 250),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        transform: GradientRotation(2.089),
                        end: Alignment.bottomCenter,
                        colors: [
                          KColor.secondPrimary,
                          KColor.primary,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: KTextStyle.headline3.copyWith(color: KColor.white),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, KSize.getHeight(context, -80)),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: KSize.getHeight(context, 345),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(4, 8), // Shadow position
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
                    child: Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IntlPhoneField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: KTextStyle.caption
                                    .copyWith(color: KColor.grey, fontSize: 16),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: KColor.primary,
                                )),
                                contentPadding: const EdgeInsets.all(15),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: KColor.primary,
                                )),
                              ),
                              onChanged: (PhoneNumber number) {
                                setState(() {
                                  dialCode = number.countryCode;
                                  countryCode = number.countryISOCode;
                                });
                                print(
                                    "Country ISO COde :${number.countryCode}");
                              },
                              onCountryChanged: (value) {
                                setState(() {
                                  countryCode = value.code;
                                  dialCode = value.dialCode;

                                  getLocation();
                                });
                                print("Country  COde :${value.code}");
                              },
                            ),
                            KTextField(
                              hintText: 'Enter you Full Name',
                              labelText: "Full Name",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,
                              isClearableField: true,
                              controller: nameController,
                              requiredField: false,
                              textInputType: TextInputType.name,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            KTextField(
                              hintText: 'Enter you password',
                              labelText: "Passwrod",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,
                              isPasswordField: true,
                              isClearableField: true,
                              controller: passwordController,
                              requiredField: false,
                              textInputType: TextInputType.text,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            KTextField(
                              hintText: 'Enter you password',
                              labelText: "Confirm Passwrod",
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,
                              isClearableField: true,
                              isPasswordField: true,

                              controller: confirmPasswordController,
                              requiredField: false,
                              textInputType: TextInputType.text,
                              // validator: (v) => Validators.fieldValidator(v),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                continueLogin
                    ? Container()
                    : Center(
                        child: Text(
                          "Currently our system doesnot support this country",
                          style:
                              KTextStyle.bodyText3.copyWith(color: KColor.grey),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer(builder: (context, ref, _) {
                        final authState = ref.watch(signupProvider);
                        return continueLogin
                            ? Expanded(
                                child: CustomButton(
                                    color: KColor.primary,
                                    textColor: KColor.white,
                                    width: double.infinity,
                                    height: 40,
                                    name: authState is! LoadingState
                                        ? "Sign Up"
                                        : 'Please wait...',
                                    onTap: () {
                                      if (phoneController.text.isEmpty) {
                                        toast(
                                            "Contact field must not be empty!",
                                            bgColor: KColor.red);
                                      } else if (nameController.text.isEmpty) {
                                        toast("Name field must not be empty!",
                                            bgColor: KColor.red);
                                      }

                                      if (passwordController.text ==
                                          confirmPasswordController.text) {
                                        if (authState is! LoadingState) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            ref
                                                .read(signupProvider.notifier)
                                                .register(
                                                  countryCode: countryCode,
                                                  dialCode: dialCode.toString(),
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                  password:
                                                      passwordController.text,
                                                );
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Password does not match"),
                                            duration: Duration(milliseconds: 1),
                                          ),
                                        );
                                      }
                                    }),
                              )
                            : Container();
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                            color: KColor.primary,
                            textColor: KColor.white,
                            width: double.infinity,
                            height: 40,
                            name: "Login",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const LoginScreen())));
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  getLocation() {
    if (userLocation == countryCode) {
      for (int i = 0; i < allowedCountries.length; i++) {
        if (allowedCountries[i] == countryCode) {
          setState(() {
            continueLogin = true;
            print("Kun Boga$continueLogin");
          });
        }
      }
    } else {
      setState(() {
        continueLogin = false;
        print("Kun Boga$continueLogin");
      });
    }
  }
}
