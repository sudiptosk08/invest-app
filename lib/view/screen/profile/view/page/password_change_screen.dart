import 'package:flutter/material.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import '../../../../global_component/textformfield/k_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var _chosenCatValue;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: GradientAppBar("My Bank")),
        backgroundColor: KColor.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Change Password",
              style: KTextStyle.subtitle1,
            ),
            const SizedBox(
              height: 5,
            ),
            KTextField(
              hintText: 'Enter Your Old Password',
              labelText: "Old Password",
              hintColor: KColor.grey,
              hasPrefixIcon: true,

              isClearableField: true,
              controller: oldPasswordController,
              requiredField: false,
              textInputType: TextInputType.phone,
              // validator: (v) => Validators.fieldValidator(v),
            ),
            KTextField(
              hintText: 'Enter Your New Password',
              labelText: "New Password",
              hintColor: KColor.grey,
              hasPrefixIcon: true,

              isClearableField: true,
              controller: newPasswordController,
              requiredField: false,
              textInputType: TextInputType.phone,
              // validator: (v) => Validators.fieldValidator(v),
            ),
            KTextField(
              hintText: 'Enter Your Confirm Password',
              labelText: "Confirm Password",
              hintColor: KColor.grey,
              hasPrefixIcon: true,

              isClearableField: true,
              controller: confirmPasswordController,
              requiredField: false,
              textInputType: TextInputType.phone,
              // validator: (v) => Validators.fieldValidator(v),
            ),
          ]),
        ));
  }
}
