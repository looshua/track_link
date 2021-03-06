import 'package:flutter/material.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/target_object.dart';


class TrackFrameTile extends StatelessWidget {
  const TrackFrameTile({
    required this.trackList,
    required this.id,
    required this.frame,
    Key? key
  }) : super(key: key);

  final TrackList trackList;
  final int id;
  final int frame;

  void _deleteTarget() {
    trackList.removeTrackFrame(id, frame);
  }

  @override
  Widget build(BuildContext context) {
    TargetObject? target = trackList.getTrackByID(id)?.getTargetByFrame(frame);
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