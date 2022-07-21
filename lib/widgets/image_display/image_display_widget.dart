import 'package:flutter/material.dart';
import 'package:track_link/widgets/image_display/components/image_display.part.dart';

class ImageDisplayWidget extends StatelessWidget {
  const ImageDisplayWidget({Key? key}) : super(key: key);

  final double minWidth = 1000;
  final double minHeight = 700;

  @override
  Widget build(BuildContext context) {
    var testWidth = MediaQuery.of(context).size.width - 400;
    var fWidth = (testWidth < 1000) ? 1000 : testWidth;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < minWidth) {
          if (constraints.maxHeight < minHeight) {
            return SizedBox(
              width: minWidth,
              height: minHeight,
              child: const MainImageDisplay(),
            );
          }
          else {
            return SizedBox(
              width: minWidth,
              height: constraints.maxHeight,
              child: const MainImageDisplay(),
            );
          }
        }
        else {
          return SizedBox(
            width: fWidth.toDouble(),
            height: constraints.maxHeight,
            child: const MainImageDisplay(),
          );
        }
      }
    );
  }
}

