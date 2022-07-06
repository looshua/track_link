import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:track_link/models/detect_list.dart';
import 'package:track_link/models/video_capture.dart';
import 'package:track_link/widgets/detect_list/components/detect_tile.part.dart';

class DetectListView extends StatelessWidget {
  const DetectListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detectList = context.watch<DetectList>();
    var videoCapture = context.watch<VideoCapture>();

    int? numDets = detectList.getFrameNum(videoCapture.activeFrame);
    if (numDets == null) return Container();

    return ListView.builder(
      itemCount: numDets,
      itemBuilder: (BuildContext context, int index) {
        return DetectFrameTile(
          detectList: detectList, 
          frame: videoCapture.activeFrame,
          index: index
        );
      },
    );
  }
}