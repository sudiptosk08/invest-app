// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/global_component/textformfield/k_text_field.dart';
import 'package:invest_app/view/screen/user_profile/controller/user_update_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/styles/k_text_style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String accessName = getStringAsync(userName);
  String accessPhone = getStringAsync(userContact);
  String dialPhoneCode = getStringAsync(dialCountryCode);
  String countryCode = getStringAsync(countryFlagCode);
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = accessName.isEmpty ? '' : accessName;
    phoneController.text = accessPhone.isEmpty ? '' : accessPhone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: SingleChildScrollView(
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
                    "Update Profile",
                    style: KTextStyle.headline3.copyWith(color: KColor.white),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, KSize.getHeight(context, -80)),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: KSize.getHeight(context, 190),
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
                            initialValue: phoneController.text,
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
                                phoneController.text = number.number;
                                dialPhoneCode = number.countryCode;
                              });
                              print("Country COde :${number.countryISOCode}");
                            },
                            initialCountryCode: countryCode,
                            onCountryChanged: (value) {
                              countryCode = "${value.code}";
                              print("InitIalCountry Code: $countryCode");
                            },
                          ),
                          KTextField(
                            hintText: 'Enter you Name',
                            labelText: " Full Name",
                            controller: nameController,
                            hintColor: KColor.grey,
                            hasPrefixIcon: true,
                            isClearableField: true,

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
              Consumer(builder: (context, ref, _) {
                final updateUserState = ref.watch(updateUserProvider);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      color: KColor.primary,
                      textColor: KColor.white,
                      width: double.infinity,
                      height: 40,
                      name: updateUserState is LoadingState
                          ? 'Please wait...'
                          : 'Update',
                      onTap: () {
                        if (updateUserState is! LoadingState) {
                          if (_formKey.currentState!.validate()) {
                            ref.read(updateUserProvider.notifier).updateUser(
                                phone: phoneController.text,
                                name: nameController.text,
                                dialCode: dialPhoneCode,
                                code: countryCode.toString());

                          }
                        }
                      }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
