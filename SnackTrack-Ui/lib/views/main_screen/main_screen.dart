import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:snacktracker_ui/views/nutrition_data/nutrition_data_screen.dart';
import 'package:snacktracker_ui/views/profile/profile_screen.dart';
import 'package:snacktracker_ui/views/recipes/recipes_screen.dart';
import 'package:snacktracker_ui/views/your_recipes/your_recipes_screen.dart';

import '../camera/camera_screen.dart';

part 'main_screen.g.dart';

@hwidget
Widget mainScreen() {
  final currentNavbarIndex = useState<int>(2);

  return Scaffold(
    backgroundColor: Colors.black,
    body: LazyIndexedStack(
      index: currentNavbarIndex.value,
      children: const [
        RecipesScreen(),
        YourRecipesScreen(),
        CameraScreen(),
        NutritionDataScreen(),
        ProfileScreen()
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentNavbarIndex.value,
      onTap: (value) {
        currentNavbarIndex.value = value;
      },
      selectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.receipt_24_regular,
            color: Colors.white,
          ),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.star_24_regular,
            color: Colors.white,
          ),
          label: 'Your Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.scan_24_regular,
            color: Colors.white,
          ),
          label: 'Tracker',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.circle_24_regular,
            color: Colors.white,
          ),
          label: 'Nutrition',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.person_24_regular,
            color: Colors.white,
          ),
          label: 'Profile',
        )
      ],
    ),
  );
}
