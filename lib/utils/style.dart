import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'SF_UI_DISPLAY');

  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );

  static final smallBigTextStyle = commonTextStyle.copyWith(
    fontSize: 12.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: textColor(1),
      fontSize: 14.0,
      fontWeight: FontWeight.w400);

  static final commonBoldTextStyle = baseTextStyle.copyWith(
      color: textColor(1),
      fontSize: 14.0,
      fontWeight: FontWeight.w500);

  static final drawerTextStyle = baseTextStyle.copyWith(
      color: textColor(1),
      fontSize: 15.0,
      fontWeight: FontWeight.w500);

  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w600);

  static final titleTextBoldStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w700);

  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);

  static Color textColor(double opacity) {
    return const Color(0xFF353E5A).withOpacity(opacity);
  }
  static Color homeBackgroundColor(double opacity) {
    return Color(0xFFDEE8FF).withOpacity(opacity);
  }
}