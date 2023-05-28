import 'package:device_preview/device_preview.dart';
import 'package:ecommerce_app/router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/palette.dart';

import 'features/auth/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ProviderScope(
        // observers: [
        //   LoggerRiverpod(),
        // ],
        child: MyApp(),
      ), // Wrap your app
    ),
  );
  //   // ProviderScope(
  //   //   // observers: [
  //   //   //   LoggerRiverpod(),
  //   //   // ],
  //   //   child: MyApp(),
  //   // ), // Wrap your app
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor)),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: whiteColor,
        appBarTheme:
            const AppBarTheme(backgroundColor: whiteColor, elevation: 0),
      ),
      debugShowCheckedModeBanner: true,
      home: const SplashScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
