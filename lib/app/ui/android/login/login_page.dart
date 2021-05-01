import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';
import 'package:sit_eat/app/ui/theme/color.grey.dart';

class LoginPage extends GetView<LoginController> {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 40,
          left: 25,
          right: 25,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [greyColor, greyLightColor],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value) {
                    

                    if (GetUtils.isNullOrBlank(value)) {
                      return "E-mail é obrigatório";
                    } else if (!GetUtils.isEmail(value)) {
                      return "E-mail inválido";
                    }
                    return null;
                  },
                  labelText: "E-mail",
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: InputField(
                  controller: _loginController.passwordTextController,
                  validator: (value) {
                    if (GetUtils.isNullOrBlank(value)) {
                      return "Senha é obrigatório";
                    }
                    return null;
                  },
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
                  if (_formKey.currentState.validate()) {
                    _loginController.login();
                  }
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
      ),
    );
  }
}
