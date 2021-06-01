import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/profile_controller.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/android/profile/profile_components/profile_botao.dart';
import 'package:sit_eat/app/ui/android/profile/profile_components/profile_foto.dart';

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
            ProfileFoto(),
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
              icon: Icon(Icons.help, color: Colors.white, size: 25),
              press: () {},
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
