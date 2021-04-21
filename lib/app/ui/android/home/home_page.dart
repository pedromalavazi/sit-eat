import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class HomePage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final UserModel user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("BEM VINDO ${user.name}"),
          ElevatedButton(
            onPressed: () {
              _loginController.logOut();
              Get.offAndToNamed(Routes.LOGIN);
            },
            child: Text(
              "Sign Out",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
