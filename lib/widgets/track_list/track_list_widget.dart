import 'package:flutter/material.dart';

import 'package:track_link/widgets/track_list/components/track_list_view.part.dart';

class TrackListWidget extends StatelessWidget {
  const TrackListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracks'),
        
      )
    );
  }
}
