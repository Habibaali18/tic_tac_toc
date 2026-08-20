import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color Yellow = Color(0xFFD5B93A);
  static Color Red = Color(0xFFFF0000);
  static Color OGreen = Color(0xFF427E11);
  static Color XRed = Color(0xFFFF0B0B);
  static Color White = Color(0xFFFFFFFF);
  static Color Black = Color(0xFF000000);
  static LinearGradient boackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Yellow, Red],
  );
}
