import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';
import '../services/user_services.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final List<String> user = [];

  void getUser() async {
    final UserServices userServices = UserServices();
    final List<String> userdata = await userServices.getUser();

    user.addAll(userdata);

    setState(() {
      user;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

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
            "My Account",
            style: TextStyle(color: blackColorShade1, fontSize: 25),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                user.length != 0
                    ? Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(user[2]),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user[0],
                                style: const TextStyle(
                                    color: blackColorShade1, fontSize: 23),
                              ),
                              Text(
                                user[1],
                                style: const TextStyle(
                                    color: blackColorShade1, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.location_on_outlined,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Shopping Address",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.access_time,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Order History",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.language_rounded,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Languages",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.privacy_tip_outlined,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Privacy Policy",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.help_outline,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Help",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.star_border_rounded,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Rate Our App",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.logout_outlined,
                      size: 25,
                    ),
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
