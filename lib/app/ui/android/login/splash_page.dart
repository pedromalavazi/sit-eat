import 'package:flutter/material.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/theme/color.grey.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SplashScreen(
            seconds: 3,
            gradientBackground: LinearGradient(
              colors: [greyColor, greyLightColor],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
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
