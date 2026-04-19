import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  List<CalculationHistory> get history => _history;

  Future<void> loadHistory() async {
    _history = await StorageService.getHistory();
    notifyListeners();
  }

  void addRecord(String expression, String result) async {
    _history.insert(0, CalculationHistory(
      expression: expression, 
      result: result, 
      timestamp: DateTime.now()
    ));
    await StorageService.saveHistory(_history);
    notifyListeners();
  }
}