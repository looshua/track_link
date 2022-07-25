import 'package:flutter/material.dart';
import 'package:track_link/widgets/video_control/components/det_future_slider.part.dart';
import 'package:track_link/widgets/video_control/components/det_history_slider.part.dart';
import 'package:track_link/widgets/video_control/components/track_future_slider.part.dart';
import 'package:track_link/widgets/video_control/components/track_history_slider.part.dart';
import 'package:track_link/widgets/video_control/components/data_controls.part.dart';

class HistoryFutureView extends StatelessWidget {
  const HistoryFutureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var testWidth = MediaQuery.of(context).size.width - 400;
    var fWidth = (testWidth < 1000) ? 1000 : testWidth;

    return SizedBox(
      height: 140,
      width: fWidth.toDouble(),
      child: Row( 
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Column(
              children: const <Widget>[
                Flexible(
                  flex: 1,
                  child: DetHistorySlider(),
                ),
                Flexible(
                  flex: 1,
                  child: TrackHistorySlider(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: fWidth - 698,
            height: 140,
            child: const DataControls(),
          ),
          Column(
            children: const <Widget>[
              Flexible(
                flex: 1,
                child: DetFutureSlider(),
              ),
              Flexible(
                flex: 1,
                child: TrackFutureSlider(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}