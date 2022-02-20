import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/app/app_widget_model.dart';
import 'package:surf_practice_chat_flutter/app/di/app_component.dart';
import 'package:surf_practice_chat_flutter/navigation/app_router.dart';

class App extends CoreMwwmWidget<AppWidgetModel> {
  App({Key? key})
      : super(
          key: key,
          widgetModelBuilder: (_) => AppWidgetModel(),
        );

  @override
  WidgetState<App, AppWidgetModel> createWidgetState() => _AppState();
}

class _AppState extends WidgetState<App, AppWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Injector.of<AppComponent>(context).component.navigator,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splashScreen,
      onGenerateRoute: (routeSettings) =>
          AppRouter.routes[routeSettings.name]!(routeSettings.arguments),
    );
  }
}
