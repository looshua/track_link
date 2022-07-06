import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/detect_list.dart';

class VideoLoaderWidget extends StatelessWidget {
  const VideoLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trackList = context.watch<TrackList>();
    var detectList = context.watch<DetectList>();
    int nTracks = trackList.getLength();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Number of Tracks: $nTracks"),
        _DummyAddTrack(trackList: trackList),
        _DummyAddDetect(detectList: detectList)
      ],
    );
  }
}

class _DummyAddTrack extends StatelessWidget {
  const _DummyAddTrack({
    required this.trackList,
    Key? key
  }) : super(key: key);

  final TrackList trackList;

  void _addDummyTrack() {
    trackList.addDummyTrack();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _addDummyTrack, 
      child: const Text("ADD TRACK")
    );
  }
}

class _DummyAddDetect extends StatelessWidget {
  const _DummyAddDetect({
    required this.detectList,
    Key? key
  }) : super(key: key);

  final DetectList detectList; 

  void _setDummyDet() {
    detectList.addDummyTrack(10);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _setDummyDet, 
      child: const Text("ADD DETS")
    );
  }
}