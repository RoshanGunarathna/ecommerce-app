void main() {
  runApp(MyAppp());
}

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
