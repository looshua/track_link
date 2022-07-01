import 'package:track_link/models/target_object.dart';
import 'package:flutter/foundation.dart';

class TrackObject extends ChangeNotifier {
  int id;
  final Map<int, TargetObject> _targetData = {};

  TrackObject(this.id);
  TrackObject.fromTarget(this.id, TargetObject target) {
    addTarget(target);
    notifyListeners();
  }

  void propagateID(int newID) {
    id = newID;
    for (TargetObject v in _targetData.values) {
      v.id = newID;
    }
  }

  void addTarget(TargetObject target) {
    TargetObject toAdd = TargetObject.fromTarget(target.frame, id, target.bbox);
    _targetData[target.frame] = toAdd;
    notifyListeners();
  }

  void removeTarget(int frame) {
    _targetData.remove(frame);
    notifyListeners();
  }

  TargetObject? getTargetByFrame(int frame) {
    return _targetData[frame];
  }
}
