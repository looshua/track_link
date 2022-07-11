import 'package:flutter/material.dart';

import 'package:track_link/widgets/track_list/components/track_list_view.part.dart';

class TrackListWidget extends StatelessWidget {
  const TrackListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    return SizedBox(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) / 2,
      width: 400,
      child: Column(
        children: const <Widget>[
          Text("Tracks"),
          Expanded(
            child: TrackListView()
          ),
        ],
      ),
    );
  }
}
