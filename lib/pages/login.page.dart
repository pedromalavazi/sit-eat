import 'package:flutter/material.dart';
import 'package:sit_eat/services/authentication_service.dart';
import 'package:sit_eat/utils/color.grey.dart';
import 'package:provider/provider.dart';

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
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [greyColors, greyLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
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
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  labelText: "E-mail",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38, width: 1.0),
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: "Senha",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38, width: 1.0),
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
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
            Container(
              height: 55,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xff424242),
                    Color(0xff757575),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Entrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        child: Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                        height: 28,
                        width: 28,
                      )
                    ],
                  ),
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                  },
                ),
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              height: 55,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: TextButton(
                        onPressed: () {
                          //Login facebook
                        },
                        child: SizedBox(
                          child: Image.asset("assets/facebook-icon.png"),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          //Login google
                        },
                        child: SizedBox(
                          child: Image.asset("assets/google2.png"),
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFF8A9CC1),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Entrar com Facebook",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/facebook-icon.png"),
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    //Login facebook
                  },
                ),
              ),
            ),
            SizedBox(
              //SizedBox serve apenas para dar um espaço na tela
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFFE06666),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Entrar com Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/google2.png"),
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    //login com google
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
