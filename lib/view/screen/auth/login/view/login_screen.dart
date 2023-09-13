import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/screen/auth/login/controller/login_controller.dart';
import 'package:invest_app/view/screen/auth/registation/view/registration_screen.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../constant/base_state.dart';
import '../../../../global_component/textformfield/k_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var dialCountryCode;
  var countryCode;
  bool continueLogin = false;
  String userLocation = getStringAsync(userPublicLocation);
  dynamic allowedCountries;

  @override
  Widget build(BuildContext context) {
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
                    "Login",
                    style: KTextStyle.headline3.copyWith(color: KColor.white),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, KSize.getHeight(context, -80)),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: KSize.getHeight(context, 200),
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
                    key: _formKey,
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
                                dialCountryCode = number.countryCode;
                                countryCode = number.countryISOCode;
                              });
                              print("Country ISO COde :${number.countryCode}");
                            },
                            onCountryChanged: (value) {
                              countryCode = value.code;
                              dialCountryCode = "+${value.dialCode}";
                              print("Country COde : $countryCode");
                            },
                          ),
                          KTextField(
                            hintText: 'Enter you password',
                            labelText: "Passwrod",
                            isPasswordField: true,
                            hintColor: KColor.grey,
                            hasPrefixIcon: true,
                            isClearableField: true,
                            controller: passwordController,
                            requiredField: false,
                            textInputType: TextInputType.text,
                            // validator: (v) => Validators.loginPasswordValidator(v),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      final authState = ref.watch(loginProvider);

                      print("Locataion$userLocation");
                      return Expanded(
                        child: CustomButton(
                            color: KColor.primary,
                            textColor: KColor.white,
                            width: double.infinity,
                            height: 40,
                            name: authState is LoadingState
                                ? 'Please wait...'
                                : 'Login',
                            onTap: () {
                              if (authState is! LoadingState) {
                                if (_formKey.currentState!.validate()) {
                                  ref.read(loginProvider.notifier).login(
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                      countryISOCode: countryCode,
                                      dialCode: dialCountryCode);
                                }
                              }
                            }),
                      );
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
                          name: "Register",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const RegistrationScreen())));
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
  }
}
