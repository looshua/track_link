import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class DetHistorySlider extends StatefulWidget {
  const DetHistorySlider({Key? key}) : super(key: key);

  @override
  State<DetHistorySlider> createState() => _DetHistorySliderState();
}

class _DetHistorySliderState extends State<DetHistorySlider> {
  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    int maxVisibleHistory = videoCapture.getMaxVisibleHistory(10);
    double currentSliderValue = videoCapture.getDetHistory.toDouble();
    String dispVal = currentSliderValue.round().toString();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 300,
              child: Text(
                "Visible Past Detections",
                textAlign: TextAlign.left,
              ),
            ),
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
                              videoCapture.setDetHistory = value.round().toInt();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
