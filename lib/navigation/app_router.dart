import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/screens/chat/chat_screen_route.dart';
import 'package:surf_practice_chat_flutter/screens/splash/splash_screen_route.dart';

class AppRouter {
  static const String chatScreen = '/chat';
  static const String splashScreen = '/';

  static final Map<String, Route Function(Object?)> routes = {
    chatScreen: (_) => ChatScreenRoute(),
    splashScreen: (_) => SplashScreenRoute(),
  };
}
