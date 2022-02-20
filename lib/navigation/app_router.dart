import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/screens/chats/chats_screen_route.dart';
import 'package:surf_practice_chat_flutter/screens/splash/splash_screen_route.dart';

class AppRouter {
  static const String chatsScreen = '/chats';
  static const String splashScreen = '/';

  static final Map<String, Route Function(Object?)> routes = {
    chatsScreen: (_) => ChatsScreenRoute(),
    splashScreen: (_) => SplashScreenRoute(),
  };
}