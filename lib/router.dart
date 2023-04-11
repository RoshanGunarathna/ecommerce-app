import 'package:ecommerce_app/features/search/controller/search_controller.dart';
import 'package:ecommerce_app/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import 'core/common/error_text.dart';

import 'features/home/screens/home_screen.dart';
import 'features/home/widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const BottomBar(),
      );
    case SearchScreen.routeName:
      final searchController = routeSettings.arguments as TextEditingController;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => SearchScreen(searchController: searchController),
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
