import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:snacktracker_ui/services/datastore.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../nutritions/nutritions_screen.dart';

part 'suggested_ingredients.g.dart';

@hwidget
Widget suggestedIngredients(
    BuildContext context, List<String> suggestions, XFile image) {
  final selectedSuggestions = useState<List<String>>(suggestions);
  final isLoading = useState(false);

  useEffect(() => null, [isLoading.value]);

  return Scaffold(
      appBar: AppBar(
        title: Text('Suggested Ingredients'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
                height: 400,
                width: 400,
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Suggested Ingredients:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChipsChoice.multiple(
              value: selectedSuggestions.value,
              onChanged: (val) {
                selectedSuggestions.value = val;
              },
              alignment: WrapAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              wrapCrossAlignment: WrapCrossAlignment.start,
              choiceCheckmark: true,
              wrapped: true,
              choiceStyle: C2ChipStyle.outlined(),
              choiceItems: C2Choice.listFrom<String, String>(
                source: suggestions,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  Datastore datastore = Datastore();
                  isLoading.value = true;
                  final nutritions =
                      await datastore.getNutritions(image, suggestions);
                  isLoading.value = false;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NutritionsScreen(nutritions),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: isLoading.value
                  ? Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text('Next'))
        ],
      ));
}
