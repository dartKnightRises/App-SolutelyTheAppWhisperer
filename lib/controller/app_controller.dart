
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/data/material_theme_data.dart';
import '../utils/json_prefs.dart';

class AppController extends GetxController {
  //will verify previous session
  RxBool isDarkModeCustom = false.obs;

  //will verify previous session and also use for switching theme
  var currentLightThemeIndex = 0.obs;
  var currentDarkThemeIndex = 1.obs;

  //list of custom themes
  final List<ThemeData> listOfCustomThemes =
      CustomMaterialThemes().materialThemeList;

  // initialising local storage for storing and retrieving brightness and theme data info
  final JsonPrefsFile themeDataStorage = JsonPrefsFile('myThemeData');

  // loading theme data value
  Future<void> loadThemeData() async {
    final loadedThemeData = await themeDataStorage.load();
    if (loadedThemeData.containsKey('myThemeData')) {
      currentLightThemeIndex.value = loadedThemeData['myThemeData'];
      currentDarkThemeIndex.value = currentLightThemeIndex.value + 1;
      await changeThemeData(currentLightThemeIndex.value);
      update();
    } else {
      await saveThemeData();
    }
  }

  // changing the current theme to new theme from list of custom theme
  Future<void> changeThemeData(int index) async {
    currentLightThemeIndex.value = index;
    currentDarkThemeIndex.value = index + 1;
    await saveThemeData();
    update();
  }

  // saving current theme index to local storage
  Future<void> saveThemeData() async {
    final dataToSave = {'myThemeData': currentLightThemeIndex.value};
    await themeDataStorage.save(dataToSave);
  }

  // app start will load this function
  Future<void> bootstrap() async {
    await loadThemeData();
  }

  @override
  void onInit() {
    super.onInit();
    bootstrap();
  }
}
