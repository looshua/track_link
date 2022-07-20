import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:track_link/models/video_reader_bindings.dart';

class VideoLoadArgs {
  final SendPort sendPort;
  final String filePath;
  VideoLoadArgs(this.sendPort, this.filePath);
}

void _loadVideo(VideoLoadArgs args) {
  VideoReader.initialize();
  int mf = VideoReader.loadVideo(args.filePath);
  args.sendPort.send(mf);
}

class VideoCapture extends ChangeNotifier {
  String videoPath = "";
  String detFilePath = "";
  String trackFilePath = "";

  int activeFrame = -1;
  int maxFrames = -1;

  int _visibleDetHistory = 0;
  int _visibleDetFuture = 0;
  int _visibleTrackHistory = 0;
  int _visibleTrackFuture = 0;

  final Map<int, String> imagePaths = {};

  Future<void> loadVideoInBackground(String filePath) async {
    if (filePath == "") return;

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

    videoPath = videoPath;
    notifyListeners();
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
