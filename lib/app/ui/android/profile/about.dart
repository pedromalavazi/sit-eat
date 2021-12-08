import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        elevation: 1,
        title: Text("Sobre"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/logo5.png"),
            )),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Aplicativo desenvolvido por: ',
                  style: TextStyle(fontSize: 22, height: 1.4, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\n'
                  'Felipe Fares Ferreira'
                  '\n'
                  'Patrik Leonardo Costa Scolari'
                  '\n'
                  'Pedro Henrique Malavazi    '
                  '\n'
                  'Rafael Rodrigues Vitor',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 120,
                ),
                Text(
                  '\n'
                  'Quaisquer problemas ou duvidas, entre em contato conosco pelo email: appsiteat@gmail.com',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
