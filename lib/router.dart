import 'package:flutter/material.dart';

import 'core/common/widgets/error_text.dart';
import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorText(
            error: 'This page doesn\'t exit',
          ),
        ),
      );
  }
}
