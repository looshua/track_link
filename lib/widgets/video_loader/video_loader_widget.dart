import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/widgets/video_loader/components/video_loader_drawer_view.part.dart';

class VideoLoaderWidget extends StatelessWidget {
  const VideoLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: VideoLoaderDrawerView()
    );
  }
}