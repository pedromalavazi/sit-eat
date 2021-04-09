import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_eat/services/authentication_service.dart';
import 'package:sit_eat/utils/color.dart';
import 'package:sit_eat/widgets/btn_widget.dart';
import 'package:sit_eat/widgets/herder_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            //Login (principal)
            HeaderContainer(" "),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                      controller: emailController,
                      hint: "E-mail",
                      icon: Icons.email,
                    ),
                    _textInput(
                      controller: passwordController,
                      hint: "Senha",
                      icon: Icons.vpn_key,
                      obscureText: true,
                      enableSuggestions: false,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Esqueceu a senha?",
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          },
                          btnText: "ENTRAR",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Não possui uma conta? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Registre-se",
                            style: TextStyle(color: redColors)),
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

  Widget _textInput(
      {controller, hint, icon, obscureText = false, enableSuggestions = true}) {
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
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
      ),
    );
  }
}
