import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';

class HomePage extends StatelessWidget {
  final UserModel user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BEM VINDO ${user.name}"),
            ButtonWidget(
              text: "Sign Out",
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
