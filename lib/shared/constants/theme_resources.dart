import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';

String getFontAccordingToLanguage(){
  return 'app_font_family'.tr;
}

ThemeData getLightThemeData(){
  return ThemeData(
    fontFamily: getFontAccordingToLanguage(),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: ColorResources.whiteColor),
      iconTheme: IconThemeData(color: ColorResources.whiteColor),
      backgroundColor: ColorResources.colorBlue,
      elevation: 5.0,
      toolbarTextStyle: TextStyle(
        fontSize: 16,
        color: ColorResources.whiteColor,
        fontFamily: getFontAccordingToLanguage(),
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: ColorResources.whiteColor,
        fontFamily: getFontAccordingToLanguage(),
      ),
    ),
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 16,
          color: ColorResources.whiteColor,
          fontFamily: getFontAccordingToLanguage(),
        )
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorResources.colorBlueLight
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 16,
          color: ColorResources.colorBlueLight,
          fontFamily: getFontAccordingToLanguage(),
        )),
  );
}