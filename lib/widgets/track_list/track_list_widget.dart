import 'package:flutter/material.dart';

import 'package:track_link/widgets/track_list/components/track_list_view.part.dart';

class TrackListWidget extends StatelessWidget {
  const TrackListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var maxHeight =
        (MediaQuery.of(context).size.height - appBar.preferredSize.height) / 2;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: maxHeight, minHeight: 200, maxWidth: 400, minWidth: 200),
      child: Column(
        children: const <Widget>[
          Text("Tracks"),
          Expanded(child: TrackListView()),
        ],
      ),
    );
  }
}
