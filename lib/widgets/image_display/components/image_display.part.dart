import 'package:flutter/material.dart';
import 'package:track_link/models/video_capture.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MainImageDisplay extends StatelessWidget {
  const MainImageDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();

    return Image.file(
      File(await videoCapture.getDisplayPath()),

    )
  }
}