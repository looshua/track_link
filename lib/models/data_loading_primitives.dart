import 'dart:isolate';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:track_link/models/video_reader_bindings.dart';


// Wrapper for passing arguments to video loading isolate
class VideoLoadArgs {
  final SendPort sendPort;
  final String filePath;
  VideoLoadArgs(this.sendPort, this.filePath);
}

// Top level function for video loading isolate
void loadVideo(VideoLoadArgs args) {
  if (!VideoReader.initialize()) {
    throw Exception("Cannot initialize OpenCV bindings.");
  }
  int mf = VideoReader.loadVideo(args.filePath);
  args.sendPort.send(mf);
}

class ImageLoadArgs {
  final SendPort sendPort;
  final Map<int, String> filePaths;
  ImageLoadArgs(this.sendPort, this.filePaths);
}

void cacheImages(ImageLoadArgs args) {
  Map<int, Uint8List> cachedImages = {};

  args.filePaths.forEach((key, value) {
    cachedImages[key] = File(value).readAsBytesSync();
  });

  args.sendPort.send(cachedImages);
}

class CacheImageProvider extends ImageProvider<CacheImageProvider> {
  final String tag;
  final Uint8List img;

  CacheImageProvider(this.tag, this.img);

  @override
  ImageStreamCompleter load(CacheImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1.0,
      debugLabel: tag,
      informationCollector: () sync* {
        yield ErrorDescription('Tag: $tag');
      },
    );
  }

  Future<Codec> _loadAsync(DecoderCallback decode) async {
    final Uint8List bytes = img;
    if (bytes.lengthInBytes == 0) {
      PaintingBinding.instance.imageCache.evict(this);
      throw StateError('$tag is empty and cannot be loaded as an image.');
    }

    return await decode(bytes);
  }

  @override
  Future<CacheImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CacheImageProvider>(this);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return ((other is CacheImageProvider) && (other.tag == tag));
  }

  @override
  int get hashCode => tag.hashCode;

  @override
  String toString() => '${objectRuntimeType(this, 'CacheImageProvider')}($tag)';
}