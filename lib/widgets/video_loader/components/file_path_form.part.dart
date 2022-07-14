import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class FilepathForm extends StatefulWidget {
  const FilepathForm({Key? key}) : super(key: key);

  @override
  State<FilepathForm> createState() => _FilepathFormState();
}

class _FilepathFormState extends State<FilepathForm> {

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();

    return Form(
      child: Column(
        children: [
          const Text("Video Path:"),
          TextFormField(
            initialValue: videoCapture.videoPath,
            onSaved: (String? value) {
              videoCapture.videoPath = value.toString();
              String tpath = videoCapture.videoPath;
              debugPrint("Saved video path is $tpath.");
            },
          )
        ],
      ),
    );
  }
}