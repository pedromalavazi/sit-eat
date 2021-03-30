import 'package:flutter/material.dart';
import 'package:sit_eat/utils/color.dart';
import 'package:sit_eat/widgets/btn_widget.dart';
import 'package:sit_eat/widgets/herder_container.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            //Cadastro
            HeaderContainer(" "),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(hint: "Nome Completo", icon: Icons.person),
                    _textInput(hint: "E-mail", icon: Icons.email),
                    _textInput(hint: "Número Celular", icon: Icons.call),
                    _textInput(hint: "Senha", icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTRAR",
                          onClick: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Já possui cadastro? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Entrar", style: TextStyle(color: redColors)),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
