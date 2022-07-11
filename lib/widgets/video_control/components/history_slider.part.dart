import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class DetHistorySlider extends StatefulWidget {
  const DetHistorySlider({
    Key? key
  }) : super(key: key);

  @override
  State<DetHistorySlider> createState() => _DetHistorySliderState();
}

class _DetHistorySliderState extends State<DetHistorySlider> {
  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    int maxVisibleHistory = videoCapture.getMaxVisibleHistory(10);
    double currentSliderValue = videoCapture.getDetHistory as double;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          "Visible Detection History",
          textAlign: TextAlign.left,
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "$currentSliderValue",
                textAlign: TextAlign.left,
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.lightBlue[50],
                  inactiveTrackColor: Colors.lightBlue[700]
                ), 
                child: Slider(
                  value: currentSliderValue,
                  max: 0,
                  min: -10,
                  divisions: 10,
                  label: currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    if (value >= maxVisibleHistory){
                      setState(() {
                        videoCapture.setDetHistory = value as int;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}