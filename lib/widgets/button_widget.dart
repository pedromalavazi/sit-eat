import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  Function function = () {};
  final double height;
  final String text;
  final double textSize;
  final Color textColor;
  final IconData icon;
  final Color iconColor;

  ButtonWidget({
    this.function,
    this.height,
    this.text,
    this.textSize,
    this.textColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: function,
          icon: Icon(
            icon,
            color: iconColor,
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size.fromHeight(height),
            ),
          ),
          label: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ),
      ],
    );
  }
}
