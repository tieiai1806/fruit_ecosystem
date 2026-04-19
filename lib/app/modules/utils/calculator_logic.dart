import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  static String calculate(String expression) {
    try {
      // 1. Chuẩn hóa các ký tự cơ bản
      String exp = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('Π', 'pi')
          .replaceAll('√', 'sqrt');

      // 2. Parser
      Parser p = Parser();
      // Nếu có log(10), thư viện này cần cú pháp log(10) là ln(10)
      // Chúng ta để nguyên biểu thức và dùng ContextModel để giải quyết
      Expression expObj = p.parse(exp);
      
      // 3. Khởi tạo ContextModel
      ContextModel cm = ContextModel();
      // Bind các giá trị hằng số
      cm.bindVariable(Variable('pi'), Number(3.141592653589793));

      // 4. Tính toán
      double eval = expObj.evaluate(EvaluationType.REAL, cm);

      if (eval.isNaN || eval.isInfinite) return "Error";
      
      String result = eval.toStringAsFixed(8);
      return (eval % 1 == 0) 
          ? eval.toInt().toString() 
          : result.replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "");
      
    } catch (e) {
      return "Error";
    }
  } 
}