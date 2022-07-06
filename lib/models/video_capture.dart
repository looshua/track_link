import 'package:flutter/widgets.dart';

class VideoCapture extends ChangeNotifier {
  int activeFrame = -1;
  int maxFrames = -1;

  final Map<int, String> imagePaths = {};

  void deltaFrame(int delta) {
    activeFrame += delta;
    activeFrame = (activeFrame < 0) ? 0 : activeFrame;
    activeFrame = (activeFrame > maxFrames) ? maxFrames : activeFrame;
    notifyListeners();
  }

  void setUpDummy() {
    activeFrame = 0;
    maxFrames = 100;
  }
}