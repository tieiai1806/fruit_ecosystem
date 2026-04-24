import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_ecosystem/app/modules/utils/calculator_logic.dart'; 
import 'history_provider.dart';

enum CalculatorMode { basic, scientific }

class CalculatorProvider extends ChangeNotifier {
  final TextEditingController expressionController = TextEditingController();
  String _result = "0";
  CalculatorMode _mode = CalculatorMode.basic;

  String get result => _result;
  CalculatorMode get mode => _mode;

  void toggleMode() {
    _mode = (_mode == CalculatorMode.basic) ? CalculatorMode.scientific : CalculatorMode.basic;
    notifyListeners();
  }

  void appendValue(String value) {
    final String text = expressionController.text;
    int cursorPosition = expressionController.selection.baseOffset;
    if (cursorPosition < 0) cursorPosition = text.length;

    final String leftPart = text.substring(0, cursorPosition);
    final String rightPart = text.substring(cursorPosition);

    expressionController.text = leftPart + value + rightPart;
    expressionController.selection =
        TextSelection.collapsed(offset: cursorPosition + value.length);

    notifyListeners();
  }

  void backspace() {
    final String text = expressionController.text;
    int cursorPosition = expressionController.selection.baseOffset;
    if (cursorPosition < 0) cursorPosition = text.length;

    if (cursorPosition > 0) {
      expressionController.text =
          text.substring(0, cursorPosition - 1) + text.substring(cursorPosition);
      expressionController.selection =
          TextSelection.collapsed(offset: cursorPosition - 1);
      notifyListeners();
    }
  }

  // ✅ FIX CE (xóa phần tử cuối)
  void clearEntry() {
    final text = expressionController.text;
    if (text.isEmpty) return;

    final newText = text.replaceFirst(RegExp(r'[^+\-*/%()]+$'), '');

    expressionController.text = newText;
    expressionController.selection =
        TextSelection.collapsed(offset: newText.length);

    notifyListeners();
  }

  void addScientificFunction(String func) {
    String valueToAdd =
        (func == 'x^y') ? '^' : (func == 'exp') ? 'e' : '$func(';
    appendValue(valueToAdd);
  }

  void calculate(BuildContext context) {
    final expression = expressionController.text;

    if (expression.isEmpty) return;

    _result = CalculatorLogic.calculate(expression);

    // ✅ chỉ lưu khi không lỗi
    if (_result != "Error") {
      Provider.of<HistoryProvider>(context, listen: false)
          .addRecord(expression, _result);
    }

    notifyListeners();
  }

  void clear() {
    expressionController.clear();
    _result = "0";
    notifyListeners();
  }

  @override
  void dispose() {
    expressionController.dispose();
    super.dispose();
  }
}