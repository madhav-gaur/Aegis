import 'package:flutter/material.dart';
import 'package:aegis/themes/app_colors.dart';

class AppFonts {
  static const String fontFamily = 'Inter';
  
  static const TextStyle screenTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
}
