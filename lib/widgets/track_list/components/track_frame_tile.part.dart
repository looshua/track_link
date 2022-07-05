import 'package:flutter/material.dart';

import 'package:track_link/models/track_object.dart';
import 'package:track_link/models/target_object.dart';


class TrackFrameTile extends StatelessWidget {
  const TrackFrameTile({
    required this.track,
    required this.frame,
    Key? key
  }) : super(key: key);

  final TrackObject track;
  final int frame;

  void _deleteTarget() {
    track.removeTarget(frame);
  }

  @override
  Widget build(BuildContext context) {
    TargetObject? target = track.getTargetByFrame(frame);
    if (target == null) return Container(); 

    return ListTile(
      title: Text(
        "Frame $frame"
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever_rounded),
        onPressed: _deleteTarget,
        tooltip: "delete data for this frame"
      ),
    );
  }
}