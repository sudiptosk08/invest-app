import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/global_component/appBar/k_app_bar.dart';
import 'package:invest_app/view/global_component/button/k_button.dart';
import 'package:invest_app/view/global_component/service/asset_service.dart';
import 'package:invest_app/view/screen/profile/controller/add_review_controller.dart';
import 'package:invest_app/view/utils/extension/extension.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:invest_app/view/utils/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../global_component/textformfield/k_text_field.dart';

class AddReviewsScreen extends StatefulWidget {
  const AddReviewsScreen({super.key});

  @override
  State<AddReviewsScreen> createState() => _AddReviewsScreenState();
}

class _AddReviewsScreenState extends State<AddReviewsScreen> {
  TextEditingController textController = TextEditingController();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final addReviewState = ref.watch(addReviewsProvider);

        return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: GradientAppBar("Add Review")),
            backgroundColor: KColor.white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          var pickedfile = await AssetService.pickImageVideo(
                              false, context, ImageSource.gallery);
                          image = pickedfile ?? image;
                          setState(() {});
                        },
                        child: Container(
                          width: context.screenWidth,
                          height: 190,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: KColor.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: image == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 24,
                                    ),
                                    const SizedBox(height: 8),
                                    Text('Click or drag files here to upload',
                                        style: KTextStyle.bodyText1),
                                  ],
                                )
                              : Image.file(
                                  File(image!.path),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      KTextField(
                        hintText: 'Enter Your Account Name',
                        labelText: " Description",
                        hintColor: KColor.grey,
                        hasPrefixIcon: true,

                        isClearableField: true,
                        controller: textController,
                        requiredField: false,
                        textInputType: TextInputType.phone,
                        // validator: (v) => Validators.fieldValidator(v),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                          color: KColor.primary,
                          textColor: KColor.white,
                          width: double.infinity,
                          height: 40,
                          name: addReviewState is LoadingState
                              ? 'Please wait...'
                              : "Submit",
                          onTap: () {
                            if (image!.path.isEmpty) {
                              toast("Upload an image !", bgColor: KColor.red);
                            } else {
                              ref.read(addReviewsProvider.notifier).addReview(
                                  image: image!.path, msg: textController.text);
                            }
                          }),
                    ]),
              ),
            ));
      },
    );
  }
}
