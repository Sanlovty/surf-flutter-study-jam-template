// ignore_for_file: avoid_redundant_argument_values, avoid_void_async

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/app/app.dart';
import 'package:surf_practice_chat_flutter/app/di/app_component.dart';
import 'package:surf_practice_chat_flutter/config/firebase_keys.dart';
import 'package:surf_practice_chat_flutter/config/firebase_options.dart';

Future<void> runApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(
      androidKey: FirebaseKeys.androidKey,
      iosKey: FirebaseKeys.iosKey,
      webKey: FirebaseKeys.webKey,
    ),
  );
  FlutterNativeSplash.remove();

  runApp(
    Injector(
      component: AppComponent(),
      builder: (ctx) => App(),
    ),
  );
}
