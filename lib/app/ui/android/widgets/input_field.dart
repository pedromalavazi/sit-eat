import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextInputType textInputType;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField(
      {this.labelText,
      this.obscure = false,
      this.stream,
      this.textInputType,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return Material(
            elevation: 5.0,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(5.0),
            borderOnForeground: false,
            child: TextFormField(
              onChanged: onChanged,
              keyboardType: textInputType,
              obscureText: obscure,
              decoration: new InputDecoration(
                labelText: labelText,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38, width: 1.0),
                ),
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                errorText: snapshot.hasError ? snapshot.error : null,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
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
