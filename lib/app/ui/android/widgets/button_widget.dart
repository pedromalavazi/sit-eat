import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  Function onPressed = () {};
  final String text;

  ButtonWidget({
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 10,
            enableFeedback: true,
            visualDensity: VisualDensity.compact,
            minimumSize: Size(200, 55),
            primary: Colors.red[500],
            shadowColor: Colors.red[500],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
