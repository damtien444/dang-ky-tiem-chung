import 'package:flutter/material.dart';

import 'colors.dart';

const kFontWeightNormal = FontWeight.w300;
const kFontWeightBold = FontWeight.w600;

const kDefaultTextStyle = TextStyle(
  fontSize: 16,
  color: kOnSecondaryColor,
  fontWeight: kFontWeightNormal,
);

final defaultTextTheme = TextTheme(
  headline6: kDefaultTextStyle,
  headline5: kDefaultTextStyle.copyWith(
    fontSize: 22,
    fontWeight: kFontWeightBold,
  ),
  bodyText2: kDefaultTextStyle.copyWith(
    fontSize: 12.6,
  ),
  subtitle2: kDefaultTextStyle.copyWith(
    fontSize: 9,
  ),
  bodyText1: kDefaultTextStyle.copyWith(
    fontSize: 14,
  ),
  subtitle1: kDefaultTextStyle.copyWith(
    fontSize: 14,
    fontWeight: kFontWeightBold,
  ),
  button: kDefaultTextStyle.copyWith(
    fontSize: 16.0,
    color: kOnPrimaryColor,
    fontWeight: kFontWeightBold,
  ),
);
