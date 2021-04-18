import 'package:flutter/material.dart';
import 'package:sit_eat/app/ui/android/login/login_page.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            ButtonWidget(
              text: "Sign Out",
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
