import 'package:track_link/models/target_object.dart';
import 'package:flutter/foundation.dart';

class DetectList extends ChangeNotifier {
  final Map<int,List<TargetObject>> _detectData = {};

  void addTarget(TargetObject target) {
    TargetObject toAdd = TargetObject.fromTarget(target.frame, -1, target.bbox);
    if (_detectData[target.frame] == null) {
      _detectData[target.frame] = <TargetObject>[];
    }
    _detectData[target.frame]?.add(toAdd);
    notifyListeners();
  }

  void removeFrame(int frame) {
    _detectData.remove(frame);
    notifyListeners();
  }

  void removeTargetByFrameIndex(int frame, int index) {
    _detectData[frame]?.removeAt(index);
    notifyListeners();
  }

  TargetObject? getTargetByFrameIndex(int frame, int index) {
    return _detectData[frame]?.elementAt(index);
  }
  
  int? getFrameNum(int frame) {
    return _detectData[frame]?.length;
  }

  void addDummyTrack(int n) {
    for (int i = 0; i < n; ++i) {
      List<TargetObject> dummy = [];
      for (int k = 0; k < 10; ++k) {
        dummy.add(TargetObject(i, -1, 1, 1, 1, 1));
      }
      _detectData[i] = dummy;
    }
    notifyListeners();
  }
}