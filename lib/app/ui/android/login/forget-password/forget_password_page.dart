import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';
import 'package:sit_eat/app/ui/theme/color.grey.dart';

class ForgetPasswordPage extends GetView<LoginController> {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 0,
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
                width: 150,
                height: 150,
                child: Image.asset("assets/logo2.png"),
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Por favor, insira seu e-mail",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 30,
              ),
              Container(
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
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 15,
              ),
              ButtonWidget(
                height: 55,
                text: "Enviar",
                textColor: Colors.black,
                textSize: 20,
                icon: Icons.send,
                iconColor: Colors.black,
                onPressed: () {
                  _loginController.resetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
