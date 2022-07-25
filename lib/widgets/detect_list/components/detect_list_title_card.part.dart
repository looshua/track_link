import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/detect_list.dart';

class DetectTitleCard extends StatelessWidget {
  const DetectTitleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detectList = context.watch<DetectList>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.question_mark),
          title: const Text("Detections"),
          trailing: IconButton(
            icon: (detectList.visible) 
              ? Icon(Icons.visibility_outlined, color: Colors.green.shade400,)
              : Icon(Icons.visibility_off_outlined, color: Colors.red.shade400,),
            onPressed: () {
              detectList.toggleVisibility();
            },
            tooltip: "toggle visibility",
          ),
        ),
      ),
    );
  }
}

