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
        if (operation.bracketsOpen == 0) {
          print(operation.hasil);
        }
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
        children: [
          Expanded(
            child: FittedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      operation.expression,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
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
            )),
          ),
        ],
      ),
    );
  }
}
