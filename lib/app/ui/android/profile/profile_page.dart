import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/controller/profile_controller.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/android/profile/profile_components/profile_botao.dart';
import 'package:sit_eat/app/ui/android/profile/profile_components/profile_foto.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
      body: BodyProfile(),
    );
  }
}

class BodyProfile extends GetView<ProfileController> {
  final UserModel user;
  final UserModel email;
  final UserModel phone;

  BodyProfile({this.user, this.email, this.phone});

  final LoginController _loginController = LoginController();



  @override
  Widget build(BuildContext context) {
    final ProfileController _homeController = Get.put(ProfileController(this.user, this.email, this.phone));
    
    return Column(
      children: [
        SizedBox(height: 50),
        ProfileFoto(),

        SizedBox(height: 10),
        Obx(
          () => Text(
            _homeController.userName.value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        //Botão Minha conta
        SizedBox(height: 60),
        ProfileBotao(
          text: "Minha conta",
          icon: Icon(Icons.person, color: Colors.white, size: 25),
          press: (){
            Get.toNamed(Routes.EDITPROFILE);
          },
        ),

        //Botão Sobre
        SizedBox(height: 35),
        ProfileBotao(
          text: "Sobre",
          icon: Icon(Icons.help, color: Colors.white, size: 25),
          press: (){},
        ),

        //Botão Sair
        SizedBox(height: 35),
        ProfileBotao(
          text: "Sair",
          icon: Icon(Icons.logout, color: Colors.white, size: 25),
          press: (){
            _loginController.logOut();
          },
        )
      ],
    );
  }
}