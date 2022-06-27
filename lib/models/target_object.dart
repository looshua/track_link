import 'dart:math';

class TargetObject {
  late int frame = -1;
  late int id = -1;
  late List<double> bbox = [-1, -1, -1, -1];

  TargetObject(this.frame, this.id, double x, double y, double w, double h) {
    bbox = [x, y, w, h];
  }
  TargetObject.fromTarget(this.frame, this.id, this.bbox);

  bool checkOverlap(List<double> otherBox) {
    if (otherBox.length != 4) return false;

    double xl = max(bbox[0], otherBox[0]);
    double xr = min(bbox[0] + bbox[2], otherBox[0] + otherBox[2]);
    if (xr < xl) return false;

    double yt = max(bbox[1], otherBox[3]);
    double yb = min(bbox[1] + bbox[3], otherBox[1] + otherBox[3]);
    if (yb < yt) return false;

    return true;
  }

  bool checkContain(double x, double y) {
    if (x < bbox[0] || x > bbox[0] + bbox[2]) return false;
    if (y < bbox[1] || y > bbox[1] + bbox[3]) return false;
    return true;
  }
}
