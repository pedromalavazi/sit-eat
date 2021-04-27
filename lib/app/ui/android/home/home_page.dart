import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/controller/login_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("BEM VINDO ${_homeController.user.name}"),
          ElevatedButton(
            onPressed: () {
              LoginController().logOut();
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
