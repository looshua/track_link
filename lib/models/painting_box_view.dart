import 'package:flutter/widgets.dart';

import 'package:track_link/models/track_list.dart';
import 'package:track_link/models/track_object.dart';
import 'package:track_link/models/detect_list.dart';
import 'package:track_link/models/target_object.dart';

class PaintBox {
  final String type;
  final int id;
  final List<int> box;

  PaintBox(this.type, this.id, this.box);
}

class PaintingBoxView {
  Map<int, List<PaintBox>> boxView = {};
  Map<int, Color> colorMap = {};

  void collate(TrackList trackList, DetectList detectList) {

  }
}