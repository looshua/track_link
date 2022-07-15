import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FilepathField extends StatelessWidget {
  const FilepathField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              // decoration: const InputDecoration(
              //   border: OutlineInputBorder()
              // ),
              controller: controller,
              validator: (String? value) {
                if (value != null && value != "") {
                  if (!File(value).existsSync()) {
                    return 'Please input a valid file path.';
                  }
                }
                return null;
              },
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () async {
              FilePickerResult? testFile = await FilePicker.platform.pickFiles(
                allowMultiple: false,
              );
              if (testFile != null && testFile.files.isNotEmpty) {
                var filePath = testFile.files.first.path;
                controller.text = filePath.toString();
              }
            },
          )
        )
      ],
    );
  }
}