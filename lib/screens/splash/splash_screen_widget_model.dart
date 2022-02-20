import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/app/di/app_component.dart';
import 'package:surf_practice_chat_flutter/assets/res/app_icons.dart';
import 'package:surf_practice_chat_flutter/navigation/app_router.dart';

SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  return SplashScreenWidgetModel(
    navigator:
        Injector.of<AppComponent>(context).component.navigator.currentState!,
    scaffoldKey: Injector.of<AppComponent>(context).component.scaffoldKey,
  );
}

/// [WidgetModel] для сплеш скрина
class SplashScreenWidgetModel extends WidgetModel
    with TickerProviderWidgetModelMixin {
  static const int _fadeDuration = 0;
  static const int _animationDuration = 100;
  static const int _splashScreenDuration = 2;

  final GlobalKey<ScaffoldState> scaffoldKey;
  final NavigatorState navigator;
  final double logoHeight = 170;
  final double logoWidth = 170;
  final String logoPath = AppIcons.splashIcon;

  late final AnimationController fadeController;
  late final AnimationController animationController;
  late final Animation animation;

  SplashScreenWidgetModel({
    required this.navigator,
    required this.scaffoldKey,
  }) : super(const WidgetModelDependencies());

  @override
  void onLoad() {
    super.onLoad();
    fadeController = AnimationController(
      duration: const Duration(milliseconds: _fadeDuration),
      vsync: this,
    );
    animation = CurvedAnimation(parent: fadeController, curve: Curves.easeIn);

    animationController = AnimationController(
      duration: const Duration(milliseconds: _animationDuration),
      vsync: this,
    )..repeat();
    _loadApp();
  }

  Future<void> _loadApp() async {
    await fadeController.forward();
    await _delay(_splashScreenDuration);
    animationController.dispose();
    fadeController.dispose();

    _openScreen(AppRouter.chatsScreen);
  }

  void _openScreen(String routeName) {
    navigator.popAndPushNamed(routeName);
  }

  Future<void> _delay(int milliseconds) async {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }
}
