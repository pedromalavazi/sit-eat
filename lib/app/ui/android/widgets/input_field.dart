import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Function validator;

  InputField(
      {this.labelText,
      this.obscure = false,
      this.textInputType,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(builder: (context, snapshot) {
      return Material(
        elevation: 5.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
        borderOnForeground: false,
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          obscureText: obscure,
          decoration: new InputDecoration(
            filled: false,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1.0),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,

            // Erros
            errorStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              backgroundColor: Colors.transparent,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      );
    });
  }
}
