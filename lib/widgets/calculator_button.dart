import 'package:flutter/material.dart';

class CalculatorButon extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Function callback;

  const CalculatorButon({this.color, this.textColor, this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
