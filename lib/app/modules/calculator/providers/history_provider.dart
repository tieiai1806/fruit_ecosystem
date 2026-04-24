import 'package:flutter/material.dart';
import '../../../../models/calculation_history.dart';
import '../../../../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  List<CalculationHistory> get history => _history;

  Future<void> loadHistory() async {
    _history = await StorageService.getHistory();
    notifyListeners();
  }

  Future<void> addRecord(String expression, String result) async {
    if (expression.isEmpty) return;

    final newRecord = CalculationHistory(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );

    _history.insert(0, newRecord);

    if (_history.length > 50) {
      _history.removeLast();
    }

    await StorageService.saveHistory(_history);
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history = [];
    await StorageService.saveHistory(_history);
    notifyListeners();
  }
}