import 'package:flutter/material.dart';

import 'package:track_link/widgets/video_control/components/history_future_view.part.dart';
import 'package:track_link/widgets/video_control/components/video_playback.part.dart';
import 'package:track_link/widgets/video_control/components/video_slider.part.dart';

class VideoControlWidget extends StatelessWidget {
  const VideoControlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        VideoSlider(),
        VideoPlayback(),
        HistoryFutureView(),
      ],
    );
  }
}


