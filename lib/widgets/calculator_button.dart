import 'package:flutter/material.dart';

class CalculatorButon extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;

  const CalculatorButon({this.color, this.textColor, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
