import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importing the Get package for state management
import '../../../controller/app_controller.dart'; // Importing the AppController

// MaterialThemeTile is a StatelessWidget used for displaying a material design themed tile
class MaterialThemeTile extends StatelessWidget {
  final ColorScheme colorScheme; // Color scheme for the tile
  final int currentLightThemeIndex; // Index of the current light theme

  // Constructor for MaterialThemeTile
  const MaterialThemeTile({
    Key? key,
    required this.colorScheme,
    required this.currentLightThemeIndex,
  });

  @override
  Widget build(BuildContext context) {
    // Using GetBuilder to access and listen to changes in the AppController
    return GetBuilder<AppController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.background,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _TileIcon(color: colorScheme.primary), // Icon widget
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Material Design Tile', // Tile title
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ColorBox(color: colorScheme.primary), // Color box for primary color
                            const SizedBox(width: 8),
                            ColorBox(color: colorScheme.secondary), // Color box for secondary color
                            const SizedBox(width: 8),
                            ColorBox(color: colorScheme.tertiary), // Color box for tertiary color
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _AdditionalFeatureSwitch(currentLightThemeIndex), // Switch widget for additional features
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ColorBox is a StatelessWidget used for displaying a colored box
class ColorBox extends StatelessWidget {
  final Color color; // Color of the box

  // Constructor for ColorBox
  const ColorBox({Key? key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

// _AdditionalFeatureSwitch is a StatefulWidget used for toggling additional features
class _AdditionalFeatureSwitch extends StatefulWidget {
  final int themeIndex; // Index of the theme

  // Constructor for _AdditionalFeatureSwitch
  const _AdditionalFeatureSwitch(this.themeIndex);

  @override
  _AdditionalFeatureSwitchState createState() =>
      _AdditionalFeatureSwitchState();
}

class _AdditionalFeatureSwitchState extends State<_AdditionalFeatureSwitch> {
  AppController appController = Get.find<AppController>(); // Accessing the AppController

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .7,
      child: Switch(
        value: appController.currentLightThemeIndex.value == widget.themeIndex, // Checking if the current theme index matches the widget's theme index
        onChanged: (newValue) {
          setState(() {
            if (newValue) {
              appController.changeThemeData(widget.themeIndex); // Changing the theme data if the switch is toggled
            }
          });
        },
        activeColor: Theme.of(context).focusColor,
        inactiveTrackColor: Theme.of(context).highlightColor,
      ),
    );
  }
}

// _TileIcon is a StatelessWidget used for displaying an icon inside the tile
class _TileIcon extends StatelessWidget {
  final Color color; // Color of the icon

  // Constructor for _TileIcon
  const _TileIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(
        Icons.favorite,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
