import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

part 'nutritions_screen.g.dart';

@swidget
Widget nutritionsScreen(BuildContext context, List<String> nutritions) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Nutrition values'),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    SleekCircularSlider(
                      initialValue: 100,
                      appearance: CircularSliderAppearance(
                        size: 115,
                        infoProperties: InfoProperties(
                          mainLabelStyle:
                              const TextStyle(color: Colors.transparent),
                          topLabelText: 'Good',
                          topLabelStyle: const TextStyle(color: Colors.white),
                        ),
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.green,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                            'Apples are rich in dietary fiber and vitamin C, making them great for digestive health and boosting the immune system.'),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SleekCircularSlider(
                      initialValue: 50,
                      appearance: CircularSliderAppearance(
                        size: 115,
                        infoProperties: InfoProperties(
                          topLabelText: 'Okay',
                          topLabelStyle: const TextStyle(color: Colors.white),
                          mainLabelStyle:
                              const TextStyle(color: Colors.transparent),
                          bottomLabelStyle:
                              const TextStyle(color: Colors.transparent),
                        ),
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.orange,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Apples contain a moderate amount of sugars, which can provide a quick energy boost but should be consumed in moderation by those monitoring their sugar intake.',
                          softWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SleekCircularSlider(
                      initialValue: 30,
                      appearance: CircularSliderAppearance(
                        size: 115,
                        infoProperties: InfoProperties(
                          topLabelText: 'Bad',
                          topLabelStyle: const TextStyle(color: Colors.white),
                          mainLabelStyle:
                              const TextStyle(color: Colors.transparent),
                          bottomLabelStyle:
                              const TextStyle(color: Colors.transparent),
                        ),
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.red,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'For individuals with certain allergies or fructose intolerance, apples might trigger allergic reactions or digestive issues due to their fructose content.',
                          softWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: nutritions.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Text(
                    nutritions[i],
                    style: const TextStyle(fontSize: 15),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Divider(color: Colors.grey),
                  ), // Added line
                ],
              );
            },
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Back to home'),
          ),
        ],
      ),
    ),
  );
}
