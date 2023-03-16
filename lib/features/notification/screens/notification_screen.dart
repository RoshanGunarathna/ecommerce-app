import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> images = [];

  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: backtoHome,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: blackColorShade1,
              size: 35,
            ),
          ),
          title: const Text(
            "Notification",
            style: TextStyle(color: blackColorShade1, fontSize: 25),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    "Today",
                    style: TextStyle(color: blackColorShade1, fontSize: 20),
                  ),
                  trailing: Text(
                    "clear all",
                    style: TextStyle(color: blackColorShade1, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "12 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Fruits",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "you set reminder for 14 jan 22",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "8 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Drinks",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "you set reminder for you appointment",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const ListTile(
                  title: Text(
                    "Yesterday",
                    style: TextStyle(color: blackColorShade1, fontSize: 20),
                  ),
                  trailing: Text(
                    "clear all",
                    style: TextStyle(color: blackColorShade1, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "12 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Vegetables",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "you set reminder for 14 jan 22",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "6 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Fruits",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "you set reminder for you appointment",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
