import 'package:flutter/material.dart';
import 'package:track_link/widgets/track_list/track_list_widget.dart';
import 'package:track_link/widgets/video_loader/video_loader_widget.dart';
import 'package:track_link/widgets/detect_list/detect_list_widget.dart';
import 'package:track_link/widgets/video_control/video_control_widget.dart';

// Master Widget class to hold the main UI objects
class MasterWidget extends StatelessWidget {
  const MasterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Link'),
        // add the see all checkbox maybe?
      ),
      body: Row(
        children: <Widget>[
            Column(
              children: const <Widget>[
                TrackListWidget(),
                DetectListWidget(),
              ],
            ),
            
          // Column(
          //   children: const <Widget>[
          //     VideoLoaderWidget(),
          //     VideoControlWidget(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
