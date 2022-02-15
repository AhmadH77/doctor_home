import 'package:flutter/material.dart';

class Constants {
  //
  static String api = "http://firstmedicalsystem.000webhostapp.com/api";

  //
  static Color teal = Color(0xFF1BB7A4);
  static Color dark_teal = Color(0xFF003102);
  static Color dark_blue = Color(0xFF0063B8); //0xFF5640FC
  static Color blue = Color(0xFF329CFA);
  static Color mid_blue = Color(0xFF178AEE);
  static Color light_blue = Color(0xFF8ABDFD);
  static Color light_light_blue = Color(0xFFB3D2FC);
  static Color tr_light_blue = Color(0xFFCEE4FF);
  static Color light_light_blue_op = Color(0x5EB3D2FC);
  static Color tr_light_blue_op = Color(0x70CEE4FF);
  // static Color light_blue = Color(0xFF8ABDFD);

  // static Color dark_blue = Color(0xFF0063B8);//0xFF5640FC
  // static Color blue = Color(0xFF329CFA);
  // static Color mid_blue = Color(0xFF178AEE);

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
