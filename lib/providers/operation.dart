import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:terbilang/terbilang.dart';

class Operation with ChangeNotifier {
  static const List<String> BUTTON_LIST = [
    'C',
    'DEL',
    '(',
    ')',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    ',',
    'ANS',
    '+',
  ];

  static const List<String> OPERATOR_LIST = ['(', ')', '/', 'x', '-', '+', '='];

  static const Map<String, Color> ACTION_BUTTON_COLOR = {
    'C': Colors.green,
    'DEL': Colors.red,
    'ANS': Colors.blue,
  };
  String _expression = '';
  int _bracketsOpen = 0;
  bool _answerMode = false;
  bool _pointOpen = false;

  String get expression => _expression;
  int get expressionLength => _expression.length;
  int get bracketsOpen => _bracketsOpen;
  bool get answerMode => _answerMode;

  String get lastChar =>
      expressionLength > 0 ? _expression.substring(expressionLength - 1) : '';

  double get hasil {
    double hasil;
    if (_expression == '') {
      return hasil;
    }
    try {
      String expression = _expression.replaceAll('x', '*');
      expression = expression.replaceAll(',', '.');
      Parser pars = Parser();
      ContextModel cm = ContextModel();
      Expression ex = pars.parse(expression);
      hasil = ex.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      print(e);
    }
    return hasil;
  }

  String get terbilang {
    Terbilang terbilang = Terbilang();
    if (this.hasil > 999999999) {
      return this.hasil % 1 == 0.0
          ? this.hasil.floor().toString()
          : this.hasil.toString();
    }
    return this.hasil != null ? terbilang.make(number: this.hasil) : ' ';
  }

  void add(String text) {
    if (_answerMode) {
      return;
    }

    if (Operation.OPERATOR_LIST.contains(text)) {
      return _addOperation(text);
    }

    if (text == ',') {
      return _pointHandler(text);
    }

    if (this.expressionLength > 0) {
      String lastChar = this.lastChar;

      if (lastChar == ')') {
        return;
      }
    }

    _expression += text;
    notifyListeners();
  }

  _addOperation(String text) {
    if (text == '(' || text == ')') {
      return _bracketHandler(text);
    }

    if (this.expressionLength == 0) {
      return;
    }

    String lastChar = this.lastChar;

    if (lastChar == text) {
      return;
    }

    if (lastChar == '(') {
      return;
    }

    if (lastChar == ',') {
      return;
    }

    _pointOpen = false;
    _expression += text;
    notifyListeners();
    return;
  }

  _bracketHandler(String text) {
    if (text == '(') {
      return _openBracketHandler(text);
    }

    return _closeBrackerHandler(text);
  }

  void _openBracketHandler(String text) {
    if (this.expressionLength == 0) {
      _expression += text;
      _bracketsOpen++;
      notifyListeners();
      return;
    }

    String lastChar = this.lastChar;

    if (_isNumeric(lastChar)) {
      // jika karakter terakhir merupakan numeric
      return;
    }

    if (lastChar == ')') {
      return;
    }

    if (text == ',') {
      return;
    }

    _expression += text;
    _bracketsOpen++;
    notifyListeners();
    return;
  }

  void _closeBrackerHandler(String text) {
    String current = _expression;
    int length = current.length;

    if (length == 0) {
      return;
    }

    if (_bracketsOpen == 0) {
      return;
    }

    String lastChar = this.lastChar;
    if (lastChar == '(') {
      return;
    }

    if (text == ',') {
      return;
    }

    _expression += text;
    _bracketsOpen--;
    notifyListeners();
    return;
  }

  _pointHandler(String text) {
    if (this.expressionLength == 0) {
      _expression += '0,';
      _pointOpen = true;
      notifyListeners();
      return;
    }

    if (_pointOpen) {
      return;
    }

    String lastChar = this.lastChar;

    if (lastChar == text) {
      return;
    }

    if (Operation.OPERATOR_LIST.contains(lastChar) && lastChar != ')') {
      _expression += '0,';
      _pointOpen = true;
      notifyListeners();
      return;
    }

    _expression += text;
    _pointOpen = true;
    notifyListeners();
    return;
  }

  void delete() {
    if (_answerMode) {
      return;
    }

    int length = _expression.length;
    if (length > 0) {
      if (this.lastChar == '(') {
        _bracketsOpen--;
      }
      _expression = _expression.substring(0, length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _answerMode = false;
    _expression = '';
    notifyListeners();
  }

  void answer() {
    if (_answerMode) {
      return;
    }

    if (this.hasil != null) {
      _answerMode = true;
      notifyListeners();
    }
  }

  bool _isNumeric(String text) {
    return double.tryParse(text) != null;
  }
}
