import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SplashScreen(
            seconds: 3,
            backgroundColor: Colors.red[500],
            navigateAfterSeconds: Routes.LOGIN,
            loaderColor: Colors.transparent,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo5.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
