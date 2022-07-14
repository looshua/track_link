import 'package:flutter/material.dart';
import 'package:track_link/widgets/video_loader/components/file_path_form.part.dart';

class VideoLoaderDrawerView extends StatelessWidget {
  const VideoLoaderDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var testHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: testHeight,
      width: 900,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Row(
              children: const [
                Expanded(
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Text("Load Files"),
                  ),
                ),
              ],
            ),
          ),
          const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8
              ),
              child: FilepathForm(),
            )
          ),
        ],
      ),
    );
  }
}