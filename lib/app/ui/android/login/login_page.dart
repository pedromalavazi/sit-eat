import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';

class LoginPage extends GetView<LoginController> {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.red,
              Colors.red[400],
              Colors.red[300],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  width: 220,
                  height: 200,
                  child: Image.asset("assets/logo2.png"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          InputField(
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
                          SizedBox(
                            height: 25,
                          ),
                          InputField(
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
                          SizedBox(
                            height: 15,
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
                              onPressed: () {
                                Get.toNamed(Routes.FORGET_PASSWORD);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Center(
                            child: ButtonWidget(
                              text: "Entrar",
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _loginController.login();
                                }
                              },
                            ),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    //           Container(
    //             margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
    //             child: InputField(
    //               controller: _loginController.passwordTextController,
    //               validator: (value) {
    //                 if (GetUtils.isNullOrBlank(value)) {
    //                   return "Senha é obrigatório";
    //                 }
    //                 return null;
    //               },
    //               labelText: "Senha",
    //               obscure: true,
    //               textInputType: TextInputType.text,
    //             ),
    //           ),
    //           Container(
    //             height: 40,
    //             alignment: Alignment.centerRight,
    //             child: TextButton(
    //               child: Text(
    //                 "Recuperar Senha",
    //                 textAlign: TextAlign.right,
    //                 style: TextStyle(
    //                   color: Colors.black54,
    //                 ),
    //               ),
    //               onPressed: () {
    //                 Get.toNamed(Routes.FORGET_PASSWORD);
    //               },
    //             ),
    //           ),
    //           SizedBox(
    //             //SizedBox serve apenas para dar um espaço na tela
    //             height: 10,
    //           ),
    //           ButtonWidget(
    //             text: "Entrar",
    //             onPressed: () {
    //               if (_formKey.currentState.validate()) {
    //                 _loginController.login();
    //               }
    //             },
    //           ),
    //           SizedBox(
    //             //SizedBox serve apenas para dar um espaço na tela
    //             height: 10,
    //           ),
    //           Container(
    //             height: 80,
    //             alignment: Alignment.bottomCenter,
    //             child: TextButton(
    //               child: Text(
    //                 "Cadastrar-se",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   color: Colors.black54,
    //                 ),
    //               ),
    //               onPressed: () {
    //                 Get.toNamed(Routes.USER_REGISTER);
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
