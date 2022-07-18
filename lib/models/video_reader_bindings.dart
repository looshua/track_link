import 'dart:ffi';
import 'package:ffi/ffi.dart';

class VideoReader {
  static late DynamicLibrary opencvApiLib;
  static late Function _loadVideo;
  static late Function addTest;

  static bool initialize() {
    opencvApiLib = (DynamicLibrary.open('libvidcap_api.so'));
    final load = opencvApiLib.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('loadVideo');
    _loadVideo = load.asFunction<int Function(Pointer<Utf8>)>();
    addTest = opencvApiLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>('add').asFunction<int Function(int, int)>();

    return true;
  }

  static bool loadVideo(String filePath) {
    final utf8FilePath = filePath.toNativeUtf8();
    bool res = _loadVideo(utf8FilePath) > 0;
    calloc.free(utf8FilePath);
    return res;
  }
}