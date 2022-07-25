import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class DetFutureSlider extends StatefulWidget {
  const DetFutureSlider({Key? key}) : super(key: key);

  @override
  State<DetFutureSlider> createState() => _DetFutureSliderState();
}

class _DetFutureSliderState extends State<DetFutureSlider> {
  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    int maxVisibleFuture = videoCapture.getMaxVisibleFuture(10);
    double currentSliderValue = videoCapture.getDetFuture.toDouble();
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
                "Visible Future Detections",
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.lightBlue[700],
                        inactiveTrackColor: Colors.lightBlue[50],
                      ),
                      child: Slider(
                        value: currentSliderValue,
                        max: 10,
                        min: 0,
                        divisions: 10,
                        label: currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          if (value <= maxVisibleFuture) {
                            setState(() {
                              videoCapture.setDetFuture = value.round().toInt();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    child: Text(
                      dispVal,
                      textAlign: TextAlign.left,
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
