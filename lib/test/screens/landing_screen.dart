import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '../palette.dart';
import '../widgets/button.dart';
import 'call_screen.dart';
import 'home_screen.dart';

//main
class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldColor,
        appBarTheme: AppBarTheme(
          backgroundColor: appBarColor,
        ),
      ),
      home: LandingScreen(),
      routes: {
        '/Home': (context) => HomePage(),
        '/Call': (context) => CallPage(),
      },
    );
  }
}

//landing screen
class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 200,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildButton(
                    label: 'Home',
                    icon: Icons.home,
                    route: '/Home',
                    iconColor: homeButtonIconColor,
                    backgroundColor: homeButtonBackgroundColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  BuildButton(
                    label: 'Call',
                    iconColor: callButtonIconColor,
                    icon: Icons.call,
                    route: '/Call',
                    backgroundColor: callButtonBackgroundColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
