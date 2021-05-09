import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool isWhiteTheme;

  ButtonWidget({
    this.onPressed,
    this.text,
    this.isWhiteTheme = false,
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
            minimumSize: Size(150, 55),
            primary: isWhiteTheme ? Colors.white : Colors.red[500],
            shadowColor: Colors.red[500],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: isWhiteTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
