import 'dart:isolate';
import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/widgets.dart';

import 'package:track_link/models/data_loading_primitives.dart';


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
  final Map<int, CacheImageProvider> cachedImageFiles = {};

  bool loadingState = false;

  // Asynchronously run video loading task
  Future<void> loadVideoInBackground(String filePath) async {
    if (filePath == "") return;

    final videoLoadPort = ReceivePort();
    VideoLoadArgs args = VideoLoadArgs(videoLoadPort.sendPort, filePath);
    final isolate = await Isolate.spawn(
      loadVideo, 
      args,
    );
    loadingState = true;
    notifyListeners();

    videoLoadPort.listen((message) {
      loadingState = false;
      if (message > 0) {
        maxFrames = message;
        activeFrame = 0;
        videoPath = filePath;
        imgFolderPath = filePath.split(".")[0];
        videoName = imgFolderPath.split("/").last;

        notifyListeners();  
      }
      videoLoadPort.close();
      isolate.kill();
    });
  }

  String? getImagePath(int testFrame) {
    if (videoName == "") return null;
    if (imgFolderPath == "") return null;

    String testPath = <String>[
      imgFolderPath,
      "${videoName}_$testFrame.jpg",
    ].join("/");

    if (File(testPath).existsSync()) {
      return testPath;
    }
    else {
      return null;
    }
  }

  Future<CacheImageProvider?> loadImage(int frameNumber) async {
    List<int> toCacheFrames = [
      frameNumber - 5,
      frameNumber - 1,
      frameNumber + 1,
      frameNumber + 5
    ];
    
    Map<int, String> filePathsToLoad = {};
    for (var frameNum in toCacheFrames) {
      if (!cachedImageFiles.containsKey(frameNum)) {
        String? testPath = getImagePath(frameNum);
        if (testPath != null) {
          filePathsToLoad[frameNum] = testPath;
        }
      }
    }

    // run the caching if needed
    if (filePathsToLoad.isNotEmpty) {
      final imageLoadPort = ReceivePort();
      ImageLoadArgs args = ImageLoadArgs(imageLoadPort.sendPort, filePathsToLoad);
      final isolate = await Isolate.spawn(
        cacheImages,
        args
      );

      imageLoadPort.listen((message) {
        for (var k in message.keys) {
          cachedImageFiles[k] = CacheImageProvider(k.toString(), message[k]);
        }
        isolate.kill();
     });
    }
 
    // return a precached image immediately
    if (cachedImageFiles.containsKey(frameNumber)) {
      return cachedImageFiles[frameNumber];
    }
    // otherwise load the image
    else {
      String? testPath = getImagePath(frameNumber);
      if (testPath == null) return null;
      cachedImageFiles[frameNumber] = CacheImageProvider(
        frameNumber.toString(), 
        File(testPath).readAsBytesSync(),
      );
      return cachedImageFiles[frameNumber];
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

}
