import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';



class EditProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
         elevation: 1,
         leading: IconButton(
           icon: Icon(Icons.arrow_back, color: Colors.white),
           onPressed: (){
             Get.toNamed(Routes.PROFILE);
           },
         ),
         title: Text("Minha Conta"),
         centerTitle: true,
       ),
       body: BodyEditProfile(),
    );
  }
}

class BodyEditProfile extends GetView<HomeController> {

  final UserModel user;
  final UserModel email;
  final UserModel phone;


  BodyEditProfile({this.user, this.email, this.phone});





  @override
  Widget build(BuildContext context) {

    final HomeController _userController = Get.put(HomeController(this.user, this.email, this.phone));

    return Container(
         padding: EdgeInsets.only(left: 16, top: 25, right: 16),
         child: GestureDetector(
           
           onTap: (){
             //Tira o foco do campo de texto quando clicar fora
             FocusScope.of(context).unfocus();
           },
           child: ListView(
             children: [
               Center(
                 child: Stack(
                   children: [
                     Container(
                       width: 130,
                       height: 130,
                       decoration: BoxDecoration(
                         border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                         ),
                         boxShadow: [
                           BoxShadow(
                             spreadRadius: 2,
                             blurRadius: 10,
                             color: Colors.black.withOpacity(0.15),
                             offset: Offset(0,10),
                           )
                         ],
                         shape: BoxShape.circle,
                         image: DecorationImage(
                           fit: BoxFit.cover,
                           image: AssetImage("assets/logo5.png"),
                         )
                       )
                     )
                   ],
                 ),
               ),

               SizedBox(height: 10),
                Obx(
                  () => Text(
                    _userController.userName.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              

              //Campo de Nome Completo
              SizedBox(height: 25),
              editProfileField("Nome Completo", _userController.userName.value , false),
              editProfileField("Número", _userController.userPhone.value, false),
              editProfileField("Email", _userController.userEmail.value, false),
              editProfileField("Senha","",  true,),

              SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //BOTÃO CANCELAR
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: (){
                      Get.toNamed(Routes.PROFILE);
                    },
                    child: Text(
                      "CANCELAR",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),

                  //BOTÃO SALVAR
                  RaisedButton(
                    onPressed: (){},
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                       "SALVAR",
                       style: TextStyle(
                         fontSize: 14,
                         letterSpacing: 2.2,
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       )
                    )
                  )
                ],
              )
             ],
           ),
         ),
    );
  }

    //Metodo dos Campos Dados
    Widget editProfileField(String labelText, String text, bool passwordField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: TextField(
        obscureText: passwordField,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom:3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: text,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
      ),
    );
  }
}