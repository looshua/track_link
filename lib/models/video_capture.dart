import 'dart:isolate';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:track_link/models/video_reader_bindings.dart';

// Wrapper for passing arguments to Isolate
class VideoLoadArgs {
  final SendPort sendPort;
  final String filePath;
  VideoLoadArgs(this.sendPort, this.filePath);
}

// Top level function for Isolate
void _loadVideo(VideoLoadArgs args) {
  if (!VideoReader.initialize()) {
    throw Exception("Cannot initialize OpenCV bindings.");
  }
  int mf = VideoReader.loadVideo(args.filePath);
  args.sendPort.send(mf);
}

class VideoCapture extends ChangeNotifier {
  String videoPath = "";
  String videoName = "";
  String imgFolderPath = "";
  String detFilePath = "";
  String trackFilePath = "";

  int activeFrame = -1;
  int maxFrames = -1;

  int _visibleDetHistory = 0;
  int _visibleDetFuture = 0;
  int _visibleTrackHistory = 0;
  int _visibleTrackFuture = 0;

  final Map<int, String> imagePaths = {};

  // Asynchronously run video loading task
  Future<void> loadVideoInBackground(String filePath) async {
    if (filePath == "") return;

    imgFolderPath = filePath.split(".")[0];
    videoName = imgFolderPath.split("/")[-1];

    final videoLoadPort = ReceivePort();
    VideoLoadArgs args = VideoLoadArgs(videoLoadPort.sendPort, filePath);
    final isolate = await Isolate.spawn(
      _loadVideo, 
      args,
    );

    videoLoadPort.listen((message) {
      if (message > 0) maxFrames = message;
      videoLoadPort.close();
      isolate.kill();
    });

    activeFrame = 0;
    videoPath = filePath;
    notifyListeners();
  }

  Future<String?> getDisplayPath() async {
    if (activeFrame == -1) return null;
    if (videoName == "") return null;
    if (imgFolderPath == "") return null;

    String testPath = <String>[
      imgFolderPath, 
      imgFolderPath, 
      "${videoName}_$activeFrame.jpg",
    ].join("/");

    if (await File(testPath).exists()) {
      return testPath;
    }
    else {
      return null;
    }
  }

  void deltaFrame(int delta) {
    activeFrame += delta;
    activeFrame = (activeFrame < 0) ? 0 : activeFrame;
    activeFrame = (activeFrame > maxFrames) ? maxFrames : activeFrame;
    notifyListeners();
  }

  int getMaxVisibleHistory(int limit) {
    return (activeFrame > limit) ? -limit : -activeFrame;
  }

  int getMaxVisibleFuture(int limit) {
    return (activeFrame + limit < maxFrames) ? limit : maxFrames - activeFrame;
  }

  void setActiveFrame(int frame) {
    if (frame < 0) {
      activeFrame = 0;
    } else if (frame > maxFrames) {
      activeFrame = maxFrames;
    } else {
      activeFrame = frame;
    }
    notifyListeners();
  }

  set setDetHistory(int hist) {
    _visibleDetHistory = hist;
    notifyListeners();
  }

  int get getDetHistory => _visibleDetHistory;
  set setDetFuture(int fut) {
    _visibleDetFuture = fut;
    notifyListeners();
  }

  int get getDetFuture => _visibleDetFuture;

  set setTrackHistory(int hist) {
    _visibleTrackHistory = hist;
    notifyListeners();
  }

  int get getTrackHistory => _visibleTrackHistory;
  set setTrackFuture(int fut) {
    _visibleTrackFuture = fut;
    notifyListeners();
  }

  int get getTrackFuture => _visibleTrackFuture;

  void setUpDummy() {
    activeFrame = 0;
    maxFrames = 100;
    notifyListeners();
  }

  Future<int> testAdd(int a, int b) async {
    return a + b;
  }
}
