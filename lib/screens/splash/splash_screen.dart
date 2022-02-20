import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/screens/splash/splash_screen_widget_model.dart';

/// [Model] сплеш скрина
class SplashScreen extends CoreMwwmWidget<SplashScreenWidgetModel> {
  const SplashScreen({
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: createSplashScreenWidgetModel,
        );

  @override
  WidgetState<SplashScreen, SplashScreenWidgetModel> createWidgetState() =>
      _SplashScreenState();
}

// Стейт сплеш скрина
class _SplashScreenState
    extends WidgetState<SplashScreen, SplashScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: FadeTransition(
        opacity: wm.fadeController,
        child: Scaffold(
          key: wm.scaffoldKey,
          backgroundColor: Colors.transparent,
          body: AnimatedBuilder(
            animation: wm.animationController,
            child: Center(
              child: SvgPicture.asset(
                wm.logoPath,
                height: wm.logoHeight,
                width: wm.logoWidth,
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: wm.animationController.value * math.pi,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
