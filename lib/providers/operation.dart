import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:terbilang/terbilang.dart';

class Operation with ChangeNotifier {
  static const List<String> BUTTON_LIST = [
    'C',
    'DEL',
    '%',
    '( )',
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

  static const List<String> OPERATOR_LIST = ['( )', '/', 'x', '-', '+', '='];

  static const Map<String, Color> ACTION_BUTTON_COLOR = {
    'C': Colors.green,
    'DEL': Colors.red,
    'ANS': Colors.blue,
  };
  String _expression = '';
  int _bracketsOpen = 0;

  String get expression => _expression;
  double get hasil {
    if (_expression == '') {
      return 0;
    }
    String expression = _expression.replaceAll('x', '*');
    Parser pars = Parser();
    ContextModel cm = ContextModel();
    Expression ex = pars.parse(expression);
    double hasil = ex.evaluate(EvaluationType.REAL, cm);
    return hasil;
  }

  String get terbilang {
    Terbilang terbilang = Terbilang();
    double hasil = this.hasil;
    return terbilang.make(number: hasil);
  }

  void add(String text) {
    String current = _expression;
    int length = current.length;
    if (Operation.OPERATOR_LIST.contains(text)) {
      //jika yang dimasukkan merupakan operator
      if (length == 0) {
        if (text == '( )') {
          _expression += '(';
          _bracketsOpen++;
          notifyListeners();
          return;
        }
      }

      String lastChar = current.substring(current.length - 1);
      //jika tombol yang dipencet tombol kurung
      if (text == '( )') {
        if (lastChar == '(') {
          //jika karakter sebelumnya kurung buka
          _expression += '(';
          _bracketsOpen++;
          notifyListeners();
          return;
        } else if (lastChar == ')') {
          //jika karakter terakhir merupakan kurung tutup
          return;
        } else if (Operation.OPERATOR_LIST.contains(lastChar)) {
          //jika karakter terakhir merupakan simbol operasi
          _expression += '(';
          _bracketsOpen++;
          notifyListeners();
          return;
        } else {
          if (_bracketsOpen > 0) {
            _expression += ')';
            _bracketsOpen--;
            notifyListeners();
            return;
          }
        }
      }
    }
    _expression += text;
    notifyListeners();
  }

  void delete() {
    int length = _expression.length;
    if (length > 0) {
      _expression = _expression.substring(0, length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _expression = '';
    notifyListeners();
  }
}
