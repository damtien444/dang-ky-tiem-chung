import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_theme.dart';
import 'color_schemes.dart';
import 'colors.dart';
import 'text_theme.dart';

final defaultAppThemeData = ThemeData(
  colorScheme: kDefaultColorScheme,
  appBarTheme: const AppBarTheme(
    color: kSecondaryColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: kPrimaryColor),
    titleTextStyle: kDefaultTextStyle,
  ),
  textTheme: defaultTextTheme,
  scaffoldBackgroundColor: kOnPrimaryColor,
  cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
    primaryColor: kOnPrimaryColor,
    barBackgroundColor: kPrimaryColor,
  ),
  elevatedButtonTheme: kElevatedButtonTheme,
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: kStrokeColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
    hintStyle: defaultTextTheme.headline6!.copyWith(color: kStrokeColor),
    errorStyle: const TextStyle(
      fontSize: 12,
      color: kError,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
