import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_eat/pages/login_page.dart';
import 'package:sit_eat/services/authentication_service.dart';
import 'package:sit_eat/widgets/btn_widget.dart';

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
              btnText: "Sign Out",
              onClick: () {
                context.read<AuthenticationService>().signOut();
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
