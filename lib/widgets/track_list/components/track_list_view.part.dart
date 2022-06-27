import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/track_object.dart';
import 'package:track_link/widgets/track_list/components/track_tile.part.dart';

class TrackListView extends StatelessWidget {
  const TrackListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trackList = context.watch<TrackList>();

    return ListView.builder(
      itemCount: trackList.getLength(),
      itemBuilder: (BuildContext context, int index) {
        TrackObject? track = trackList.getTrackByIndex(index);

        if (track == null) {
          return Container();
        }

        return TrackTile(track: track);
      },
    );
  }
}
