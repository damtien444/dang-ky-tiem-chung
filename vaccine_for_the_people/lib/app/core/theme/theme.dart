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
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color.alphaBlend(
      kOnSurface.withOpacity(0.80),
      kSurface,
    ),
  ),
  textTheme: defaultTextTheme,
  scaffoldBackgroundColor: kBackGround,
  cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
    primaryColor: kOnPrimaryColor,
    barBackgroundColor: kPrimaryColor,
  ),
  elevatedButtonTheme: kElevatedButtonTheme,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kPrimaryColor,
    elevation: 0,
    selectedLabelStyle: kDefaultTextStyle.copyWith(
      fontSize: 10,
      color: kOnPrimaryColor,
    ),
    unselectedLabelStyle: kDefaultTextStyle.copyWith(
      fontSize: 10,
      color: kOnPrimaryColor,
    ),
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
    selectedItemColor: kOnPrimaryColor,
    unselectedItemColor: kOnPrimaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: kStrokeColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
    hintStyle: defaultTextTheme.headline6!.copyWith(color: kStrokeColor),
    errorStyle: const TextStyle(
      fontSize: 14,
      color: kError,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: kDividerColor,
    thickness: 1,
  ),
);
