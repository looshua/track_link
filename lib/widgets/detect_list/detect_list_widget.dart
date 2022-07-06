import 'package:flutter/material.dart';

import 'package:track_link/widgets/detect_list/components/detect_list_view.part.dart';

class DetectListWidget extends StatelessWidget {
  const DetectListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    return SizedBox(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) / 2,
      width: 400,
      child: Column(
        children: const <Widget>[
          Text("Detections"),
          Expanded(
            child: DetectListView()
          ),
        ],
      ),
    );
  }
}
