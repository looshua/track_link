import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

import 'dart:io';

class FilepathForm extends StatefulWidget {
  const FilepathForm({Key? key}) : super(key: key);

  @override
  State<FilepathForm> createState() => _FilepathFormState();
}

class _FilepathFormState extends State<FilepathForm> {
  final _formKey = GlobalKey<FormState>();

  final videoPathController = TextEditingController();
  final detFilePathController = TextEditingController();
  final trackFilePathController = TextEditingController();

  @override
  void dispose() {
    videoPathController.dispose();
    detFilePathController.dispose();
    trackFilePathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Text("Video Path:"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: videoPathController,
              validator: (String? value) {
                if (value != null && value != '') {
                  if (!File(value).existsSync()) {
                    return 'Please enter a valid file path.';
                  }
                }
                return null;
              },
            ),
          ),
          const Text("Detection File Path:"),
          TextFormField(
            controller: detFilePathController,
            validator: (String? value) {
              if (value != null && value != '') {
                if (!File(value).existsSync()) {
                  return 'Please enter a valid file path.';
                }
              }
              return null;
            },
          ),
          const Text("Track File Path:"),
          TextFormField(
            controller: trackFilePathController,
            validator: (String? value) {
              if (value != null && value != '') {
                if (!File(value).existsSync()) {
                  return 'Please enter a valid file path.';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
