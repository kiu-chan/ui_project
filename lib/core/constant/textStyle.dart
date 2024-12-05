import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/color.dart';

sealed class AppTextStyle {
  static const appBarStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const headLineStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const bodyStyle = TextStyle(
    fontSize: 18,
    color: AppColors.textColor,
  );

  static const viewAllStyle = TextStyle(
    fontSize: 18,
    color: AppColors.primaryColor,
  );

  static const headStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const saved = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const bodyStyle1 = TextStyle(
    fontSize: 15,
    color: AppColors.textColor,
  );

  static const buttonText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
}
