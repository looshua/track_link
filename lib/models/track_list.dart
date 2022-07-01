import 'package:track_link/models/target_object.dart';
import 'package:track_link/models/track_object.dart';
import 'package:flutter/foundation.dart';

class TrackList extends ChangeNotifier {
  final Map<int, TrackObject> _trackData = {};
  int _idCounter = 0;

  TrackList(this._idCounter);

  void addTrack(TrackObject track) {
    if (track.id == -1) {
      _idCounter++;
      _trackData[_idCounter] = track;
      _trackData[_idCounter]?.propagateID(_idCounter);
    } else {
      _trackData[track.id] = track;
    }
    notifyListeners();
  }

  void removeTrack(int id) {
    _trackData.remove(id);
    notifyListeners();
  }

  int getLength() {
    return _trackData.length;
  }

  TrackObject? getTrackByID(int id) {
    return _trackData[id];
  }

  TrackObject? getTrackByIndex(int index) {
    return _trackData.values.elementAt(index);
  }

  List getTrackFramesSorted() {
    return _trackData.keys.toList()..sort();
  }
}
