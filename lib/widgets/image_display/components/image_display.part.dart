import 'package:flutter/material.dart';
import 'package:track_link/models/video_capture.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:track_link/models/data_loading_primitives.dart';
// import 'dart:typed_data';

class MainImageDisplay extends StatefulWidget {
  const MainImageDisplay({Key? key}) : super(key: key);

  @override
  State<MainImageDisplay> createState() => _MainImageDisplayState();
}

class _MainImageDisplayState extends State<MainImageDisplay> {
  CacheImageProvider _savedSnapshot = CacheImageProvider(
    "saved", 
    kTransparentImage
  );

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();

    if (videoCapture.imgFolderPath != ""){
      return Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: _savedSnapshot,
              ),
            ),
          ),
          FutureBuilder<CacheImageProvider?>(
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
                  _savedSnapshot = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Image(
                        image: snapshot.data!,
                      ),
                    ),
                  );
                }
              }
              else {
                return Center(
                  child: Image(
                    image: _savedSnapshot
                  ),
                );
              }
            },
          ),
        ],
      );
    }
    else {
      if (videoCapture.loadingState) {
        return Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Column(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: Text("Loading video..."),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
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
}