import 'package:flutter/material.dart';
import 'package:track_link/models/video_capture.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:typed_data';

class MainImageDisplay extends StatelessWidget {
  const MainImageDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();


    if (videoCapture.imgFolderPath != ""){
      return Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          FutureBuilder<Uint8List?>(
            future: videoCapture.loadImage(videoCapture.activeFrame),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Column(
                        children: const <Widget>[
                          Text("Error loading image."),
                          Icon(Icons.error_outline),
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: MemoryImage(snapshot.data!),
                      ),
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator()
              );
            },
          ),
        ],
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          child: const Text("Load a video"),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        )
      );
    }
  }
}