import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const yellow100 = Color(0xFFEBD290);
  static const yellow200 = Color(0xFFD2B08E);
  static const yellow300 = Color(0xFFC49D73);

  static const greyRing100 = Color(0xFFBFCAD9);
  static const greyRing200 = Color(0xFFA2B2C8);

  static const greyCenter100 = Color(0xFFB2B6BF); // 56% (opacity)
  static const greyCenter200 = Color(0xFFF7F7F7); //54%

  static const greyOuter100 = Color(0xFFB1B5BE);
  static const greyOuter200 = Color.fromARGB(255, 243, 242, 242);
}


extension AppColorsExtension on Color {
  Color get shade100 => withOpacity(0.56);
  Color get shade200 => withOpacity(0.54);
}