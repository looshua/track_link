import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/track_object.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({
    required this.track,
    Key? key,
  }) : super(key: key);

  final TrackObject track;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
