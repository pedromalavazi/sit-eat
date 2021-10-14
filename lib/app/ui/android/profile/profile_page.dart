import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/profile_controller.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/android/profile/profile_components/profile_botao.dart';
import 'package:sit_eat/app/ui/android/profile/profile_components/profile_photo.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final ProfileController _profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ProfilePhoto(),
            // SizedBox(
            //   height: 130,
            //   width: 130,
            //   child: Stack(
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //               width: 4,
            //               color: Theme.of(context).scaffoldBackgroundColor),
            //           boxShadow: [
            //             BoxShadow(
            //               spreadRadius: 2,
            //               blurRadius: 10,
            //               color: Colors.black.withOpacity(0.15),
            //               offset: Offset(0, 10),
            //             )
            //           ],
            //           shape: BoxShape.circle,
            //           image: DecorationImage(
            //             fit: BoxFit.cover,
            //             image: NetworkImage(_profileController.userImage.value),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 10),
            Obx(
              () => Text(
                _profileController.user.value.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 30),
            ProfileBotao(
              text: "Minha conta",
              icon: Icon(Icons.person, color: Colors.white, size: 25),
              press: () {
                Get.toNamed(Routes.EDIT_PROFILE);
              },
            ),
            //Botão Sobre
            ProfileBotao(
              text: "Sobre",
              icon: Icon(Icons.info, color: Colors.white, size: 25),
              press: () {
                Get.toNamed(Routes.ABOUT);
              },
            ),
            //Botão Sair
            ProfileBotao(
              text: "Sair",
              icon: Icon(Icons.logout, color: Colors.white, size: 25),
              press: () {
                _profileController.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
