class CalculationHistory {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationHistory({required this.expression, required this.result, required this.timestamp});

  // Chuyển đổi sang Map để lưu vào Shared Preferences
  Map<String, dynamic> toMap() => {
    'expression': expression,
    'result': result,
    'timestamp': timestamp.toIso8601String(),
  };

  factory CalculationHistory.fromMap(Map<String, dynamic> map) => CalculationHistory(
    expression: map['expression'],
    result: map['result'],
    timestamp: DateTime.parse(map['timestamp']),
  );
}