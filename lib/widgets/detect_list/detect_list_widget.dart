import 'package:flutter/material.dart';

import 'package:track_link/widgets/detect_list/components/detect_list_view.part.dart';
import 'package:track_link/widgets/detect_list/components/detect_list_title_card.part.dart';

class DetectListWidget extends StatelessWidget {
  const DetectListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var testHeight = (MediaQuery.of(context).size.height - appBar.preferredSize.height) / 2;
    return SizedBox(
      height: (testHeight < 200) ? 200 : testHeight,
      width: 400,
      child: Column(
        children: const <Widget>[
          DetectTitleCard(),
          Expanded(
            child: DetectListView()
          ),
        ],
      ),
    );
  }
}
