import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class VideoControlWidget extends StatelessWidget {
  const VideoControlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    int viewFrame = videoCapture.activeFrame;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Current Frame: $viewFrame"),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                videoCapture.deltaFrame(-1);
              },
              icon: const Icon(Icons.arrow_left),
            ),
            IconButton(
              onPressed: () {
                videoCapture.deltaFrame(1);
              },
              icon: const Icon(Icons.arrow_right),
            ),
          ],
        ),
      ],
    );
  }
}