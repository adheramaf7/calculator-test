import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './../providers/operation.dart';
import './../widgets/calculator_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final buttonList = Operation.BUTTON_LIST;
  final operatorList = Operation.OPERATOR_LIST;
  final actionButtonColor = Operation.ACTION_BUTTON_COLOR;

  void _buttonTap(String text) {
    final operation = Provider.of<Operation>(context, listen: false);
    switch (text) {
      case 'DEL':
        operation.delete();
        break;
      case 'C':
        operation.clear();
        break;
      case 'ANS':
        operation.answer();
        break;
      default:
        operation.add(text);
    }
  }

  Color _buttonColor(String text) {
    if (actionButtonColor.containsKey(text)) {
      return actionButtonColor[text];
    }
    if (operatorList.contains(text)) {
      return Colors.blueGrey[900];
    }

    return Colors.blueGrey[400];
  }

  @override
  Widget build(BuildContext context) {
    final operation = Provider.of<Operation>(context);

    // String expression = '(6+2)+(6+2)';
    // Parser pars = Parser();
    // ContextModel cm = ContextModel();
    // Expression ex = pars.parse(expression);
    // double hasil = ex.evaluate(EvaluationType.REAL, cm);
    // print(hasil);

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  child: FittedBox(
                    child: Text(
                      operation.answerMode
                          ? operation.hasil.toString()
                          : (operation.expressionLength > 0
                              ? operation.expression
                              : ' '),
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    operation.answerMode ? operation.expression : ' ',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    operation.answerMode ? operation.terbilang : ' ',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: buttonList.length,
              itemBuilder: (BuildContext context, int index) => CalculatorButon(
                callback: () => _buttonTap(buttonList[index]),
                text: buttonList[index],
                color: _buttonColor(buttonList[index]),
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
