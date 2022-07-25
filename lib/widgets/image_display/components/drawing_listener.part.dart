import 'package:flutter/material.dart';

class DrawingListener extends StatelessWidget {
  const DrawingListener({Key? key}) : super(key: key);

  void _initBoxDraw(PointerEvent click) {

  }

  void _updateBoxDraw(PointerEvent click) {

  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _initBoxDraw,
      onPointerMove: _updateBoxDraw,
    );
  }
}

