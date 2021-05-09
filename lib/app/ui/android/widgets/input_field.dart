import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Function validator;

  InputField({
    this.labelText,
    this.obscure = false,
    this.textInputType,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(225, 95, 27, .3),
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]))),
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: textInputType,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: labelText,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
