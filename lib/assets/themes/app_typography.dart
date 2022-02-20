import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';

const defaultFontFamily = 'Roboto';

class AppTypography {
  static const textAuthorMessage = TextStyle(
    letterSpacing: 0.8,
    fontWeight: FontWeight.w100,
    fontFamily: defaultFontFamily,
    color: AppColors.white,
  );
  static const textStrangerMessage = TextStyle(
    letterSpacing: 0.8,
    fontWeight: FontWeight.w100,
    fontFamily: defaultFontFamily,
    color: AppColors.middleGreenYellow,
  );
}
