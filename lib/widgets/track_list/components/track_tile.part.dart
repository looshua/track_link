import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/track_object.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({
    required this.trackList,
    required this.frame,
    Key? key,
  }) : super(key: key);

  final TrackList trackList;
  final int frame;

  @override
  Widget build(BuildContext context) {
    TrackObject? track = trackList[frame];

    // null check
    if (track == null) return Container();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('Frame $frame', textAlign: TextAlign.left,),
          ),

        ]
      )
    );
  }
}
