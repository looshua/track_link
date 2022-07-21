import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/detect_list.dart';
import 'package:track_link/models/video_capture.dart';

class DataControls extends StatelessWidget {
  const DataControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>(); 
    var trackList = context.watch<TrackList>();
    var detectList = context.watch<DetectList>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: (() => trackList.addDummyTrack()),
              child: const Text("Add Track"),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: (() => detectList.addDummyTrack(10)),
              child: const Text("Add Detections"),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: (() => videoCapture.setUpDummy()),
              child: const Text("Create Dummy Video"),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}