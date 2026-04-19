import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_ecosystem/app/modules/utils/calculator_logic.dart';

void main() {
  group('Scientific Calculator Logic Tests', () {
    // Cập nhật danh sách testCase để khớp với logic mới trong CalculatorLogic
   final testCases = [
  {'input': '5+3', 'expected': '8'},
  {'input': '(5+3)*2', 'expected': '16'},
  {'input': 'sqrt(9)', 'expected': '3'},
  {'input': '2^3', 'expected': '8'},
];

    for (var testCase in testCases) {
      test('Test: ${testCase['input']} should be ${testCase['expected']}', () {
        // Lưu ý: Nếu kết quả thực tế có sai số cực nhỏ ở chữ số thập phân thứ 8,
        // bạn có thể dùng matcher `contains` hoặc `closeTo` nếu cần.
        // Với bài tập này, so sánh chuỗi là đủ.
        expect(CalculatorLogic.calculate(testCase['input']!), testCase['expected']);
      });
    }
  });
}