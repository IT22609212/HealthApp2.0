import 'package:flutter/material.dart';

class AppColors {
  static const Color baseColor = const Color.fromARGB(255, 32, 107, 219);
  static const Color baseColorDarker = Color(0xFF002247);
  static const Color navBarColor = Color(0xFF002247);
  static const LinearGradient baseColorGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 118, 215),
      Color.fromARGB(255, 0, 0, 255),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Color baseColorForG = Color.fromARGB(255, 255, 255, 255);
  static const Color blueishWhite = Color.fromARGB(255, 250, 254, 255);
  static const Color secondaryColor = Colors.green;
  static const Color thirdColor = Color.fromARGB(255, 244, 141, 52);
  static const Color bicon = Color.fromARGB(255, 75, 73, 72);
  static const Color barwave = Color.fromARGB(255, 171, 240, 255);

  static const Color redAlertColor = Color.fromARGB(255, 244, 65, 52);

  // Add more colors as needed
}
