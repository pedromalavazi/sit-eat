import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/ui/android/login/login_page.dart';
import 'package:sit_eat/app/ui/android/navigation/navigation_page.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticated.value ? NavigationPage() : LoginPage());
  }
}
