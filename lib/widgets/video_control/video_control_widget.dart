import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

import 'package:track_link/widgets/video_control/components/history_slider.part.dart';

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
        Column(
          children: <Widget>[
            _SetUpDummyVideo(
              videoCapture: videoCapture
            ),
            SizedBox(
              width: 1000,
              height: 400,
              child: Row(
                children: <Widget>[
                  const DetHistorySlider(),
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
            ),
          ],
        ),
      ],
    );
  }
}

class _SetUpDummyVideo extends StatelessWidget {
  const _SetUpDummyVideo({
    required this.videoCapture,
    Key? key
  }) : super(key: key);

  final VideoCapture videoCapture;

  void _setDummyVideo() {
    videoCapture.setUpDummy();
  }

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: _setDummyVideo, 
      child: const Text("MAKE VIDEO")
    );
  }
}