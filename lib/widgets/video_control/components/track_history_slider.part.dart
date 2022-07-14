import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class TrackHistorySlider extends StatefulWidget {
  const TrackHistorySlider({Key? key}) : super(key: key);

  @override
  State<TrackHistorySlider> createState() => _TrackHistorySliderState();
}

class _TrackHistorySliderState extends State<TrackHistorySlider> {
  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    int maxVisibleHistory = videoCapture.getMaxVisibleHistory(10);
    double currentSliderValue = videoCapture.getTrackHistory.toDouble();
    String dispVal = currentSliderValue.round().toString();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 25,
                child: Text(
                  dispVal,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: 300,
                child: SliderTheme(
                  data: SliderThemeData(
                      activeTrackColor: Colors.lightBlue[50],
                      inactiveTrackColor: Colors.lightBlue[700]),
                  child: Slider(
                    value: currentSliderValue,
                    max: 0,
                    min: -10,
                    divisions: 10,
                    label: currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      if (value >= maxVisibleHistory) {
                        setState(() {
                          videoCapture.setTrackHistory = value.round().toInt();
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 300,
          child: Text(
            "Visible Past Tracks",
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
