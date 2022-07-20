import 'package:flutter/material.dart';
import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/detect_list.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';
import 'package:track_link/widgets/master_widget.dart';

void main() {
  runApp(const TrackLinkApp());
}

class TrackLinkApp extends StatelessWidget {
  const TrackLinkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetectList>(
          create: (context) => DetectList(),
        ),
        ChangeNotifierProvider<TrackList>(
          create: (context) => TrackList(0)
        ),
        ChangeNotifierProvider<VideoCapture>(
          create: (context) => VideoCapture()
        ),
      ],
      child: const MaterialApp(
        title: "Track Link",
        home: MasterWidget(), //VideoLoaderWidget()
      ),
    );
  }
}