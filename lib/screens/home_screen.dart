import './../widgets/calculator_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const List<String> BUTTON_LIST = [
    'C',
    'DEL',
    '( )',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '00',
    ',',
    '=',
  ];

  static const OPERATOR_LIST = ['( )', '/', 'x', '-', '+', '='];

  bool _isOperator(String text) {
    return OPERATOR_LIST.contains(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(30),
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'nol',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: BUTTON_LIST.length,
              itemBuilder: (BuildContext context, int index) => CalculatorButon(
                text: BUTTON_LIST[index],
                color: _isOperator(BUTTON_LIST[index])
                    ? Colors.blueGrey[900]
                    : (index == 0
                        ? Colors.green
                        : (index == 1 ? Colors.red : Colors.blueGrey[400])),
                textColor: Colors.white,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
