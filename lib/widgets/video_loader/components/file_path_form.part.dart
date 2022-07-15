import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_link/models/video_capture.dart';
import 'package:track_link/widgets/video_loader/components/file_path_field.part.dart';

class FilepathForm extends StatefulWidget {
  const FilepathForm({Key? key}) : super(key: key);

  @override
  State<FilepathForm> createState() => _FilepathFormState();
}

class _FilepathFormState extends State<FilepathForm> {
    final _videoPathController = TextEditingController();
    final _detFilePathController = TextEditingController();
    final _trackFilePathController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var videoCapture = context.watch<VideoCapture>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          Row(
            children: const <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text("Video Path:"),    
                ),
              ),
            ],
          ),
          FilepathField(
            controller: _videoPathController
          ),
          Row(
            children: [
              Container(
                height: 50,
              ) ,
            ],
          ),
          Row(
            children: const <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text("Detection File Path:"),    
                ),
              ),
            ],
          ),
          FilepathField(
            controller: _detFilePathController
          ),
          Row(
            children: [
              Container(
                height: 50,
              ) ,
            ],
          ),
          Row(
            children: const <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text("Track File Path:"),    
                ),
              ),
            ],
          ),
          FilepathField(
            controller: _trackFilePathController
          ),
          Row(
            children: [
              Container(
                height: 50,
              ) ,
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(8), 
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                    }
                  }, 
                  child: const Text("Load Data"),
                ),
              ),
            ],  
          ),
        ],
      ),
    );
  }
}