import 'package:flutter/material.dart';
import 'package:sit_eat/app/ui/android/login/login_page.dart';
import 'package:sit_eat/app/ui/theme/color.grey.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';

class RegisterPage extends StatelessWidget {
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
              begin: Alignment.topCenter),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo2.png"),
            ),
            Container(
              child: InputField(
                labelText: "E-mail",
                textInputType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              child: InputField(
                labelText: "Nome completo",
                textInputType: TextInputType.name,
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              child: InputField(
                labelText: "Número do celular",
                textInputType: TextInputType.phone,
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              child: InputField(
                labelText: "Senha",
                obscure: true,
                textInputType: TextInputType.text,
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              child: InputField(
                labelText: "Confirmação de senha",
                obscure: true,
                textInputType: TextInputType.text,
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            ButtonWidget(
              height: 55,
              text: "Cadastrar",
              textColor: Colors.black,
              textSize: 20,
              icon: Icons.add,
              iconColor: Colors.black,
              function: () {},
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
