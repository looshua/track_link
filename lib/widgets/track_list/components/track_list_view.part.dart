import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/widgets/track_list/components/track_tile.part.dart';

class TrackListView extends StatelessWidget {
  const TrackListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trackList = context.watch<TrackList>();
    List<int>? sortedIDs = trackList.getTrackIDsSorted();

    if (sortedIDs == null) return Container();

    return ListView.builder(
      controller: ScrollController(),
      itemCount: trackList.getLength(),
      itemBuilder: (BuildContext context, int index) {
        int id = sortedIDs[index];
        return TrackTile(trackList: trackList, id: id);
      },
    );
  }
}
