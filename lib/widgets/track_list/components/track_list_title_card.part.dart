import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/track_list.dart';

class TrackTitleCard extends StatelessWidget {
  const TrackTitleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trackList = context.watch<TrackList>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.check),
          title: const Text("Tracks"),
          trailing: IconButton(
            icon: (trackList.visible) 
              ? Icon(Icons.visibility_outlined, color: Colors.green.shade400,)
              : Icon(Icons.visibility_off_outlined, color: Colors.red.shade400,),
            onPressed: () {
              trackList.toggleVisibility();
            },
            tooltip: "toggle visibility",
          ),
        ),
      ),
    );
  }
}

