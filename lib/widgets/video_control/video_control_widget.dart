import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

import 'package:track_link/widgets/video_control/components/history_slider.part.dart';
import 'package:track_link/widgets/video_control/components/video_playback.part.dart';
import 'package:track_link/widgets/video_control/components/video_slider.part.dart';

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
        const VideoSlider(),
        const VideoPlayback(),
        _SetUpDummyVideo(videoCapture: videoCapture),
        SizedBox(
          width: 1000,
          height: 400,
          child: Row(
            children: const <Widget>[
              DetHistorySlider(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SetUpDummyVideo extends StatelessWidget {
  const _SetUpDummyVideo({required this.videoCapture, Key? key})
      : super(key: key);

  final VideoCapture videoCapture;

  void _setDummyVideo() {
    videoCapture.setUpDummy();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _setDummyVideo, child: const Text("MAKE VIDEO"));
  }
}
