import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class VideoPlayback extends StatelessWidget {
  const VideoPlayback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            videoCapture.deltaFrame(-5);
          },
          icon: const Icon(Icons.fast_rewind_rounded),
        ),
        IconButton(
          onPressed: () {
            videoCapture.deltaFrame(-1);
          },
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        IconButton(
          onPressed: () {
            videoCapture.deltaFrame(0);
          },
          icon: const Icon(Icons.play_arrow_rounded),
        ),
        IconButton(
          onPressed: () {
            videoCapture.deltaFrame(1);
          },
          icon: const Icon(Icons.skip_next_rounded),
        ),
        IconButton(
          onPressed: () {
            videoCapture.deltaFrame(5);
          },
          icon: const Icon(Icons.fast_forward_rounded),
        ),
      ],
    );
  }
}
