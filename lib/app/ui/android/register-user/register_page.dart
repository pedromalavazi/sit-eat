import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/ui/theme/color.grey.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';

class RegisterPage extends StatelessWidget {
  final LoginController _loginController = LoginController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset("assets/logo2.png"),
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
              Container(
                child: InputField(
                  controller: _loginController.nameTextController,
                  validator: (value) {
                    if (GetUtils.isNullOrBlank(value)) {
                      return "Nome é obrigatório";
                    }
                    return null;
                  },
                  labelText: "Nome completo",
                  textInputType: TextInputType.name,
                ),
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 15,
              ),
              Container(
                child: InputField(
                  controller: _loginController.phoneNumberTextController,
                  validator: (value) {
                    if (GetUtils.isNullOrBlank(value)) {
                      return "Número é obrigatório";
                    } else if (!GetUtils.isPhoneNumber(value)) {
                      return "Número inválido";
                    }
                    return null;
                  },
                  labelText: "Número do celular",
                  textInputType: TextInputType.phone,
                ),
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 15,
              ),
              Container(
                child: InputField(
                  controller: _loginController.passwordTextController,
                  validator: (value) {
                    if (GetUtils.isNullOrBlank(value)) {
                      return "Senha é obrigatório";
                    } else if (value.length < 6) {
                      return "Senha deve conter 6 caracteres";
                    }
                    return null;
                  },
                  labelText: "Senha",
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 15,
              ),
              Container(
                child: InputField(
                  controller: _loginController.confirmPasswordTextController,
                  validator: (value) {
                    if (GetUtils.isNullOrBlank(value)) {
                      return "Confirmação de senha é obrigatório";
                    } else if (value !=
                        _loginController.passwordTextController.text) {
                      return "Confirmação de senha deve ser igual a senha";
                    }
                    return null;
                  },
                  labelText: "Confirmação de senha",
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 15,
              ),
              ButtonWidget(
                height: 55,
                text: "Cadastrar",
                textColor: Colors.black,
                textSize: 20,
                icon: Icons.add,
                iconColor: Colors.black,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _loginController.register();
                  }
                },
              ),
              SizedBox(
                //SizedBox serve apenas para dar um espaço na tela
                height: 15,
              ),
              Container(
                height: 40,
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  child: Text(
                    "Voltar",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
