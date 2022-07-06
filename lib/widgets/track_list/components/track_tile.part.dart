import 'package:flutter/material.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/track_object.dart';

import 'package:track_link/widgets/track_list/components/track_frame_tile.part.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({
    required this.trackList,
    required this.id,
    Key? key,
  }) : super(key: key);

  final TrackList trackList;
  final int id;

  void _deleteTrack() {
    trackList.removeTrack(id);
  }

  @override
  Widget build(BuildContext context) {
    TrackObject? track = trackList.getTrackByID(id);

    // null check
    if (track == null) return Container();

    // generate target frame tiles
    List<Widget> targetTiles = [];
    List<int>? frames = track.getTargetsInFrameOrder();

    if (frames == null) return Container();
    frames.forEach(((element) => targetTiles.add(
      TrackFrameTile(trackList: trackList, id: id, frame: element)))
    );

    // generate expandable tile
    return ExpansionTile(
      title: Text("Track $id"),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever_rounded),
        onPressed: _deleteTrack,
        tooltip: "delete this track"
      ),
      children: targetTiles,
    );
  }
}
