import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Brightness _brightness = Brightness.light; //Default brightness is light

  // Function to toggle brightness
  void _toggleBrightness(bool isLight) {
    setState(() {
      _brightness = isLight ? Brightness.light : Brightness.dark;
    });

    // Update System UI overlay style to reflect the new brightness

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: isLight ? Colors.white : Colors.black,
      statusBarColor: isLight ? Colors.white : Colors.black,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
      isLight ? Brightness.dark : Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _brightness, // Set the app's brightness theme
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Brightness App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Brightness"),
              Switch(
                  value: _brightness ==
                      Brightness
                          .light, //Set switch value based on current brightness

                  onChanged: (value) => _toggleBrightness(
                      value) //Toggle brightness when switch is changed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
