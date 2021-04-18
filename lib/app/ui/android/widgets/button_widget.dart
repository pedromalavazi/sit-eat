import 'package:flutter/material.dart';
import 'package:sit_eat/app/ui/theme/app_theme.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  Function function = () {};
  final double height;
  final String text;
  final double textSize;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;

  ButtonWidget(
      {this.function,
      this.height,
      this.text,
      this.textSize,
      this.textColor,
      this.icon,
      this.iconColor,
      this.buttonColor});

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
          style: ElevatedButton.styleFrom(
            elevation: 10,
            enableFeedback: true,
            minimumSize: Size.fromHeight(height),
            primary: appThemeData.primaryColor,
            shadowColor: Colors.red,
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
