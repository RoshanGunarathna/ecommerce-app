import 'package:flutter/material.dart';

import 'package:test_project/auth/screeens/login_screen.dart';

import '../../../auth/services/for_firebase_backend.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        position: PopupMenuPosition.under,

        // icon by default "3 dot" icon
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('Sign Out'),
            ),
          ];
        },
        onSelected: (value) async {
          if (value == 0) {
            final firebaseServices = FirebaseServices();
            final isOk = await firebaseServices.signOut(context);
            if (isOk) {
              // ignore: use_build_context_synchronously
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false);
            }
          }
        });
  }
}
