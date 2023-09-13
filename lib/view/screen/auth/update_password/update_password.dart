import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/global_component/textformfield/k_text_field.dart';
import 'package:invest_app/view/screen/auth/update_password/controller/update_password_controller.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_size.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
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
                      "Change Password",
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
                            KTextField(
                              hintText: 'Enter you old password',
                              labelText: " Old Password",
                              controller: oldPassController,
                              hintColor: KColor.grey,
                              hasPrefixIcon: true,
                              isClearableField: true,
                              requiredField: false,
                              textInputType: TextInputType.text,
                              // validator: (v) => Validators.loginPasswordValidator(v),
                            ),
                            KTextField(
                              hintText: 'Enter you new password',
                              labelText: " New Password",
                              controller: newPassController,
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
                  final updateUserState = ref.watch(passwordUpdateProvider);
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
                              ref
                                  .read(passwordUpdateProvider.notifier)
                                  .updatePassword(
                                    oldPass: oldPassController.text,
                                    newPass: newPassController.text,
                                  );
                            }
                          }
                        }),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
