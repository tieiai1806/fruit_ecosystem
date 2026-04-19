import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../modules/utils/calculator_logic.dart';

// 1. Định nghĩa Mode
enum CalculatorMode { basic, scientific }

class CalculatorProvider extends ChangeNotifier {
  String _expression = "";
  String _result = "0";
  double _memory = 0;
  bool _hasMemory = false;
  
  // 2. Biến trạng thái Mode
  CalculatorMode _mode = CalculatorMode.basic;

  String get expression => _expression;
  String get result => _result;
  bool get hasMemory => _hasMemory;
  CalculatorMode get mode => _mode; // Getter cho UI

  // 3. Hàm chuyển đổi Mode
  void toggleMode() {
    _mode = (_mode == CalculatorMode.basic) 
            ? CalculatorMode.scientific 
            : CalculatorMode.basic;
    notifyListeners();
  }

  void appendValue(String value) {
    _expression += value;
    notifyListeners();
  }

  void addScientificFunction(String func) {
    _expression += "$func(";
    notifyListeners();
  }

  void calculate() {
    _result = CalculatorLogic.calculate(_expression);
    notifyListeners();
  }

  void clear() {
    _expression = "";
    _result = "0";
    notifyListeners();
  }

  // --- Các hàm Memory ---
  void memoryAdd() {
    _memory += double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memorySubtract() {
    _memory -= double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memoryRecall() {
    _expression = _memory.toString();
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    notifyListeners();
  }
}