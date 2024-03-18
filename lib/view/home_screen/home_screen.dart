import 'package:app_solutely/controller/app_controller.dart'; // Importing the AppController
import 'package:app_solutely/view/home_screen/widgets/material_theme_tiles.dart'; // Importing the MaterialThemeTile widget
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../model/data/material_schema_data.dart'; // Importing the MaterialSchemaData model

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (appController) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome to home screen"), // Welcome text
              // MaterialThemeTile is a widget to display various theme data
              MaterialThemeTile(
                colorScheme: appController.isDarkModeCustom.value
                    ? MaterialSchemaOne().darkSchema
                    : MaterialSchemaOne().lightSchema,
                currentLightThemeIndex: 0,
              ),
              MaterialThemeTile(
                colorScheme: appController.isDarkModeCustom.value
                    ? MaterialSchemaTwo().darkSchema
                    : MaterialSchemaTwo().lightSchema,
                currentLightThemeIndex: 2,
              ),
              // Adding more MaterialThemeTile widgets for different color schemes
              MaterialThemeTile(
                colorScheme: appController.isDarkModeCustom.value
                    ? MaterialSchemaThree().darkSchema
                    : MaterialSchemaThree().lightSchema,
                currentLightThemeIndex: 4,
              ),
              MaterialThemeTile(
                colorScheme: appController.isDarkModeCustom.value
                    ? MaterialSchemaFour().darkSchema
                    : MaterialSchemaFour().lightSchema,
                currentLightThemeIndex: 6,
              ),
            ],
          ),
        ),
      );
    });
  }
}
