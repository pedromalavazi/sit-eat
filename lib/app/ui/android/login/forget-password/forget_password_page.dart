import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';

class ForgetPasswordPage extends GetView<LoginController> {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      "Recuperar Senha",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                          SizedBox(
                            height: 40,
                          ),
                          InputField(
                            controller: _loginController.emailTextController,
                            labelText: "E-mail",
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (GetUtils.isNullOrBlank(value)) {
                                return "E-mail é obrigatório";
                              } else if (!GetUtils.isEmail(value)) {
                                return "E-mail inválido";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: ButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _loginController.resetPassword();
                                }
                              },
                              text: "Enviar",
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Voltar",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
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
  }
}
