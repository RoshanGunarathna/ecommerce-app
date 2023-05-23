import 'package:ecommerce_app/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import 'core/common/error_text.dart';

import 'features/address/screens/address_screen.dart';

import 'features/cart/screens/cart_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/home/widgets/bottom_bar.dart';

import 'features/order_history/screens/order_history_screen.dart';
import 'features/payment/screens/payment_screen.dart';
import 'features/privacyPolicy/screens/privacy_policy_scree.dart';

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

    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const CartScreen(),
      );
    case AddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddressScreen(),
      );
    case PaymentScreen.routeName:
      final arguments = routeSettings.arguments as List;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => PaymentScreen(
            total: arguments[0] as double, selectedProductList: arguments[1]),
      );

    case PrivacyPolicy.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => PrivacyPolicy(),
      );

    case OrderHistory.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => OrderHistory(),
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
