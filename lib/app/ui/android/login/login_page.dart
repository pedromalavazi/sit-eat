import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';
import 'package:sit_eat/app/ui/theme/color.grey.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [greyColor, greyLightColor],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 220,
              height: 220,
              child: Image.asset("assets/logo2.png"),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: InputField(
                controller: _loginController.emailTextController,
                labelText: "E-mail",
                textInputType: TextInputType.emailAddress,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: InputField(
                controller: _loginController.passwordTextController,
                labelText: "Senha",
                obscure: true,
                textInputType: TextInputType.text,
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            ButtonWidget(
              height: 55,
              text: "Entrar",
              textColor: Colors.black,
              textSize: 18,
              icon: Icons.login,
              iconColor: Colors.black,
              onPressed: () {
                _loginController.login();
              },
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              height: 80,
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text(
                  "Cadastrar-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  Get.toNamed(Routes.USER_REGISTER);
                },
              ),
            ),
            // Container(
            //   height: 60,
            //   alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //     color: Color(0xFF8A9CC1),
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(5),
            //     ),
            //   ),
            //   child: SizedBox.expand(
            //     child: TextButton(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text(
            //             "Entrar com Facebook",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //               fontSize: 20,
            //             ),
            //             textAlign: TextAlign.left,
            //           ),
            //           Container(
            //             child: SizedBox(
            //               child: Image.asset("assets/facebook-icon.png"),
            //               height: 28,
            //               width: 28,
            //             ),
            //           ),
            //         ],
            //       ),
            //       onPressed: () {
            //         //Login facebook
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   //SizedBox serve apenas para dar um espaço na tela
            //   height: 10,
            // ),
            // Container(
            //   height: 60,
            //   alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //     color: Color(0xFFE06666),
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(5),
            //     ),
            //   ),
            //   child: SizedBox.expand(
            //     child: TextButton(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text(
            //             "Entrar com Google",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //               fontSize: 20,
            //             ),
            //             textAlign: TextAlign.left,
            //           ),
            //           Container(
            //             child: SizedBox(
            //               child: Image.asset("assets/google2.png"),
            //               height: 28,
            //               width: 28,
            //             ),
            //           ),
            //         ],
            //       ),
            //       onPressed: () {
            //         //login com google
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
