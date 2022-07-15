import 'package:flutter/widgets.dart';
import 'dart:io';

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

  void loadVideo(String filePath) async {

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
}
