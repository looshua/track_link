import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';

class VideoSlider extends StatefulWidget {
  const VideoSlider({Key? key}) : super(key: key);

  @override
  State<VideoSlider> createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider> {
  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();
    String currentFrame = (videoCapture.activeFrame < 0) 
      ? "0"
      : videoCapture.activeFrame.toString();
    String maxFrame = (videoCapture.maxFrames < 0) 
      ? "0" 
      : videoCapture.maxFrames.toString();

    double displayActiveFrame = (videoCapture.activeFrame < 0)
        ? 0
        : videoCapture.activeFrame.toDouble();
    double displayMaxFrame =
        (videoCapture.maxFrames < 1) ? 1 : videoCapture.maxFrames.toDouble();
    int displayFrameDivisions = displayMaxFrame.toInt();

    var testSliderLength = MediaQuery.of(context).size.width - 400;
    var fSliderLength = (testSliderLength < 1000) ? 1000 : testSliderLength;

    return SizedBox(
      width: fSliderLength.toDouble(),
      child: Row(
        children: [
          SizedBox(
            width: fSliderLength - 100,
            child: SliderTheme(
              data: SliderThemeData(
                  activeTrackColor: Colors.lightBlue[700],
                  inactiveTrackColor: Colors.lightBlue[50]),
              child: Slider(
                value: displayActiveFrame,
                max: displayMaxFrame,
                min: 0,
                divisions: displayFrameDivisions,
                label: currentFrame,
                onChanged: (double value) {
                  setState(() {
                    videoCapture.setActiveFrame(value.round().toInt());
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              "$currentFrame / $maxFrame",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
