// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_screen.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class CameraScreen extends HookConsumerWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      cameraScreen(_ref);
}

class CameraView extends HookConsumerWidget {
  const CameraView(
    this.cameraDescriptions, {
    Key? key,
  }) : super(key: key);

  final List<CameraDescription> cameraDescriptions;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      cameraView(
        _context,
        cameraDescriptions,
      );
}
