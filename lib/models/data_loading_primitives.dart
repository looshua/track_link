import 'dart:isolate';
import 'dart:io';
import 'dart:typed_data';
import 'package:track_link/models/video_reader_bindings.dart';


// Wrapper for passing arguments to video loading isolate
class VideoLoadArgs {
  final SendPort sendPort;
  final String filePath;
  VideoLoadArgs(this.sendPort, this.filePath);
}

// Top level function for video loading isolate
void loadVideo(VideoLoadArgs args) {
  if (!VideoReader.initialize()) {
    throw Exception("Cannot initialize OpenCV bindings.");
  }
  int mf = VideoReader.loadVideo(args.filePath);
  args.sendPort.send(mf);
}

class ImageLoadArgs {
  final SendPort sendPort;
  final Map<int, String> filePaths;
  ImageLoadArgs(this.sendPort, this.filePaths);
}

void cacheImages(ImageLoadArgs args) {
  Map<int, Uint8List> cachedImages = {};

  args.filePaths.forEach((key, value) {
    cachedImages[key] = File(value).readAsBytesSync();
  });

  args.sendPort.send(cachedImages);
}