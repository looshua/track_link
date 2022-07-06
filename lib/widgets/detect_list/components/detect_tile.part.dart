import 'package:flutter/material.dart';

import 'package:track_link/models/target_object.dart';
import 'package:track_link/models/detect_list.dart';


class DetectFrameTile extends StatelessWidget {
  const DetectFrameTile({
    required this.detectList,
    required this.frame,
    required this.index,
    Key? key
  }) : super(key: key);

  final DetectList detectList;
  final int frame;
  final int index;

  void _deleteTarget() {
    detectList.removeTargetByFrameIndex(frame, index);
  }

  @override
  Widget build(BuildContext context) {
    TargetObject? target = detectList.getTargetByFrameIndex(frame, index);
    if (target == null) return Container(); 

    return ListTile(
      title: Text(
        "Frame $frame"
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever_rounded),
        onPressed: _deleteTarget,
        tooltip: "delete data for this frame"
      ),
    );
  }
}