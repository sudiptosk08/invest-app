// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';

import '../../utils/styles/k_text_style.dart';

class AttachmentSourceChoiceDialog extends StatefulWidget {
  final bool isAllowFiles;

   AttachmentSourceChoiceDialog({this.isAllowFiles = false});

  @override
  _AttachmentSourceChoiceDialogState createState() => _AttachmentSourceChoiceDialogState();
}

class _AttachmentSourceChoiceDialogState extends State<AttachmentSourceChoiceDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      title: Text("Select attachment source:", style: KTextStyle.subtitle1.copyWith(fontWeight: FontWeight.w500)),
      actions: <Widget>[
        MaterialButton(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              Container(
                  padding:const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: KColor.primary.withOpacity(0.1), borderRadius:const BorderRadius.all(Radius.circular(10))),
                  child:const Icon(CupertinoIcons.camera_fill, color: KColor.primary)),
             const SizedBox(height: 5),
              Text("Camera", style: KTextStyle.caption),
             const SizedBox(height: 5),
            ],
          ),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        MaterialButton(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: KColor.primary.withOpacity(0.1), borderRadius:const BorderRadius.all(Radius.circular(10))),
                  child:const Icon(Icons.image, color: KColor.primary)),
              const SizedBox(height: 5),
              Text("Gallery", style: KTextStyle.caption),
              const SizedBox(height: 5),
            ],
          ),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
        if (widget.isAllowFiles)
          MaterialButton(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Container(
                    padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: KColor.primary.withOpacity(0.1), borderRadius:const BorderRadius.all(Radius.circular(10))),
                    child:const Icon(Icons.file_copy, color: KColor.primary, size: 35)),
                const SizedBox(height: 5),
                Text("Files", style: KTextStyle.caption),
                const SizedBox(height: 5),
              ],
            ),
            onPressed: () => Navigator.pop(context, 'file'),
          )
      ],
    );
  }
}
