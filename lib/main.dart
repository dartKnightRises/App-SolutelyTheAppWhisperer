import 'package:app_solutely/view/home_screen/home_screen.dart'; // Importing the HomeScreen widget
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Importing the Get package for state management

import 'controller/app_controller.dart'; // Importing the AppController

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lazy initialization of AppController
  Get.lazyPut(() => AppController());

  await AppController().bootstrap(); // Bootstrapping the AppController

  runApp(const MyApp()); // Running the application
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final appController = Get.find<AppController>(); // Accessing the AppController using Get.find

      // Determining the current theme based on the selected mode (light/dark)
      final currentTheme = appController.isDarkModeCustom.value
          ? appController
          .listOfCustomThemes[appController.currentDarkThemeIndex.value]
          : appController
          .listOfCustomThemes[appController.currentLightThemeIndex.value];

      // Setting the status bar color based on the primary color of the current theme
      return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: currentTheme.colorScheme.primary,
        ),
        // Using GetMaterialApp for navigation and theme management
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: currentTheme, // Setting the light theme
          darkTheme: currentTheme, // Setting the dark theme
          themeMode: appController.isDarkModeCustom.value
              ? ThemeMode.dark // Setting the theme mode based on custom dark mode toggle
              : ThemeMode.light,
          home: const HomeScreen(), // Setting the home screen
        ),
      );
    });
  }
}
