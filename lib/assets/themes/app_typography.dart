import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';

const defaultFontFamily = 'Roboto';

class AppTypography {
  static const textAuthorMessage = TextStyle(
    letterSpacing: 0.8,
    fontWeight: FontWeight.w100,
    fontFamily: defaultFontFamily,
    fontSize: 14,
    color: AppColors.platinum,
  );
  static const textStrangerMessage = TextStyle(
    letterSpacing: 0.8,
    fontWeight: FontWeight.w100,
    fontFamily: defaultFontFamily,
    fontSize: 14,
    color: AppColors.cadetBlueCrayola,
  );
  static const nicknameAuthorMessage = TextStyle(
    letterSpacing: 1,
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    fontSize: 15,
    color: AppColors.white,
  );
  static const nicknameStrangerMessage = TextStyle(
    letterSpacing: 1,
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    fontSize: 15,
    color: AppColors.vodka,
  );
  static const dateTimeAuthorMessage = TextStyle(
    letterSpacing: 0.8,
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    fontSize: 12,
    color: AppColors.gray11,
  );
  static const dateTimeStrangerMessage = TextStyle(
    letterSpacing: 0.8,
    fontWeight: FontWeight.bold,
    fontFamily: defaultFontFamily,
    fontSize: 12,
    color: AppColors.sonicSilver,
  );
}
