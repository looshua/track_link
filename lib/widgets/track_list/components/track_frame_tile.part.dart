import 'package:provider/provider.dart';
import 'package:flutter/material.dart';




class TrackFrameTile extends StatelessWidget {
  const TrackFrameTile({
    required this.track,
    required this.frame,
    Key? key
  }) : super(key: key);

  final TrackObject track;
  final int frame;

  @override
  Widget build(BuildContext context) {
    if (track.getTrackByID(frame) == null) return Container(); 


    return Container();
  }
}