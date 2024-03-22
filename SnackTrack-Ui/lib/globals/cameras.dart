import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cameras.g.dart';

@riverpod
class Cameras extends _$Cameras {
  Future<List<CameraDescription>> build() async {
    return await availableCameras();
  }
}