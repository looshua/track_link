import 'package:flutter/widgets.dart';

class VideoCapture extends ChangeNotifier {
  int activeFrame = -1;
  int maxFrames = -1;

  int _visibleDetHistory = 0;
  int _visibleDetFuture = 0;
  int _visibleTrackHistory = 0;
  int _visibleTrackFuture = 0;

  final Map<int, String> imagePaths = {};

  void deltaFrame(int delta) {
    activeFrame += delta;
    activeFrame = (activeFrame < 0) ? 0 : activeFrame;
    activeFrame = (activeFrame > maxFrames) ? maxFrames : activeFrame;
    notifyListeners();
  }

  int getMaxVisibleHistory(int limit) {
    return (activeFrame > limit) ? -limit : activeFrame - limit;
  }

  int getMaxVisibleFuture(int limit) {
    return (activeFrame + limit < maxFrames) ? limit : maxFrames - activeFrame;
  }

  set setDetHistory(int hist) {_visibleDetHistory = hist;}
  int get getDetHistory => _visibleDetHistory;
  set setDetFuture(int fut) {_visibleDetFuture = fut;}
  int get getDetFuture => _visibleDetFuture;

  set setTrackHistory(int hist) {_visibleTrackHistory = hist;}
  int get getTrackHistory => _visibleTrackHistory;
  set setTrackFuture(int fut) {_visibleTrackFuture = fut;}
  int get getTrackFuture => _visibleTrackFuture;

  void setUpDummy() {
    activeFrame = 0;
    maxFrames = 100;
    notifyListeners();
  }
}