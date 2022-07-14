import 'package:flutter/material.dart';
import 'package:track_link/widgets/track_list/track_list_widget.dart';
import 'package:track_link/widgets/detect_list/detect_list_widget.dart';
import 'package:track_link/widgets/video_control/video_control_widget.dart';
import 'package:track_link/widgets/image_display/image_display_widget.dart';
import 'package:track_link/widgets/video_loader/video_loader_widget.dart';

// Master Widget class to hold the main UI objects
class MasterWidget extends StatelessWidget {
  const MasterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Link'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.folder),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const VideoLoaderWidget(),
      body: Row(
        children: <Widget>[
          Column(
            children: const <Widget>[
              TrackListWidget(),
              DetectListWidget(),
            ],
          ),
            
          Column(
            children: const <Widget>[
              Expanded(
                child:  ImageDisplayWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                ),
                child: VideoControlWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
