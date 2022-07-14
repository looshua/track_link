import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class TrackFutureSlider extends StatefulWidget {
  const TrackFutureSlider({Key? key}) : super(key: key);

  @override
  State<TrackFutureSlider> createState() => _TrackFutureSliderState();
}

class _TrackFutureSliderState extends State<TrackFutureSlider> {
  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    int maxVisibleFuture = videoCapture.getMaxVisibleFuture(10);
    double currentSliderValue = videoCapture.getTrackFuture.toDouble();
    String dispVal = currentSliderValue.round().toString();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
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
                          videoCapture.setTrackFuture = value.round().toInt();
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
        const SizedBox(
          width: 300,
          child: Text(
            "Visible Future Tracks",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
