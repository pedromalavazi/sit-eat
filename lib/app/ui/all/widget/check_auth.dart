import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/ui/android/login/login_page.dart';
import 'package:sit_eat/app/ui/android/navigation/navigation_page.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget loginPage;
    Widget loggedPage;
    if (Platform.isAndroid) {
      loginPage = LoginPage();
      loggedPage = NavigationPage();
    } else {
      //loginPage = página da web
      //loggedPage = página logada da web
    }

    return Obx(() =>
        AuthService.to.userIsAuthenticated.value ? loggedPage : loginPage);
  }
}
