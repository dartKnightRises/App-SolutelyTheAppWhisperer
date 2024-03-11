import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// This constant string is used as a key to store the theme preference in SharedPreferences
const String brightnessKey = "isLightTheme";


void main() {
  // Starts the app by running the MyApp widget
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Boolean variable to store the current theme preference (light or dark)
  bool isLightTheme = true;

  // Brightness variable to hold the current brightness value based on the theme
  Brightness brightness = Brightness.light;

  // IconData variable to store the icon data for the theme selection button (sun or moon)
  IconData iconData = Icons.wb_sunny;

  // This function retrieves the saved theme preference from SharedPreferences on app launch
  Future<void> _getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isLightTheme = prefs.getBool(brightnessKey) ?? true;
    _setBrightness(); // Call _setBrightness() to update brightness based on retrieved preference
  }

  // This function updates the brightness and icon data based on the current theme preference
  void _setBrightness() {
    setState(() {
      brightness = isLightTheme ? Brightness.light : Brightness.dark;
      iconData = isLightTheme ? Icons.wb_sunny : Icons.nightlight_round;
    });
  }

  // This function toggles the theme preference (light/dark) and updates the UI accordingly
  void _toggleTheme() {
    setState(() {
      isLightTheme = !isLightTheme;
      _setBrightness(); // Update brightness and icon data after toggling theme
    });
    SharedPreferences.getInstance().then((prefs) => prefs.setBool(brightnessKey, isLightTheme));
  }

  @override
  void initState() {
    super.initState();
    _getPrefs(); // Call _getPrefs() to retrieve theme preference on app launch
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Sets the theme of the app based on the current brightness value
      theme: ThemeData(
        brightness: brightness,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Brightness App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select Brightness:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                // Displays the sun icon for light theme and moon icon for dark theme
                icon: Icon(iconData),
                iconSize: 50,
                onPressed: _toggleTheme, // Calls _toggleTheme() on button press
                color: isLightTheme ? Colors.yellow[700] : Colors.grey[700], // Set button color based on theme
              ),
              const SizedBox(height: 10),
              Text(
                isLightTheme ? 'Light Mode' : 'Dark Mode',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isLightTheme ? Colors.black : Colors.white, // Text color changes based on theme
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

