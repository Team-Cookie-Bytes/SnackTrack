import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:camera/camera.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snacktracker_ui/services/datastore.dart';

import '../../globals/cameras.dart';
import '../suggested_ingredients/suggested_ingredients.dart';

part 'camera_screen.g.dart';

@hcwidget
Widget cameraScreen(WidgetRef ref) {
  final file = useState<File?>(null);
  final cameras = ref.watch(camerasProvider).valueOrNull;

  if (cameras == null) {
    return const Center(child: CircularProgressIndicator());
  }

  return CameraView(cameras);
}

@hcwidget
Widget cameraView(
    BuildContext context, List<CameraDescription> cameraDescriptions) {
  // Use a state to keep track of the initialization status.
  final isInit = useState<bool>(false);
  final isLoading = useState<bool>(false);
  // Use a state for potential errors.
  final error = useState<String?>(null);

  // Initialize a CameraController with the first camera (usually the rear camera).
  final CameraController controller = useMemoized(
    () => CameraController(
      cameraDescriptions[0],
      ResolutionPreset.high,
    ),
    // Dependency array ensures this is only called once or when dependencies change.
    [cameraDescriptions],
  );

  // Handle controller initialization.
  useEffect(() {
    Future<void> initCamera() async {
      try {
        await controller.initialize();
        if (controller.value.isInitialized) {
          isInit.value = true;
        }
      } catch (e) {
        error.value = e.toString();
      }
    }

    initCamera();

    return () {
      controller.dispose();
    };
  }, [controller]);

  useEffect(() {}, [isLoading.value]);

  if (error.value != null) {
    // Display an error if initialization failed.
    return Center(child: Text('Camera Error: ${error.value}'));
  } else if (isInit.value) {
    // If the controller is initialized, return the CameraPreview.
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CameraPreview(
            controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final datastore = Datastore();
                        final image = await controller.takePicture();
                        isLoading.value = true;
                        final suggestions =
                            await datastore.getSuggestions(image);
                        isLoading.value = false;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SuggestedIngredients(
                              suggestions,
                              image,
                            ),
                          ),
                        );
                      } catch (e) {
                        isLoading.value = false;
                        print('Error taking picture: $e');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: isLoading.value
                          ? const CircularProgressIndicator()
                          : const Icon(FluentIcons.camera_24_regular),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else {
    // Show a loading indicator while the camera is initializing.
    return const Center(child: CircularProgressIndicator());
  }
}
