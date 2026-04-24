import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  static String calculate(String expression) {
    try {
      String exp = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('Π', 'pi')
          .replaceAll('√', 'sqrt')
          .replaceAll('x^y', '^');

      // ✅ FIX log(x) → log(10,x)
      exp = exp.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (match) {
        return 'log(10,${match.group(1)})';
      });

      Parser p = Parser();
      Expression expObj = p.parse(exp);

      ContextModel cm = ContextModel();
      cm.bindVariable(Variable('pi'), Number(3.141592653589793));
      cm.bindVariable(Variable('e'), Number(2.718281828459045));

      double eval = expObj.evaluate(EvaluationType.REAL, cm);

      if (eval.isNaN || eval.isInfinite) return "Error";

      String result = eval.toStringAsFixed(8);

      return (eval % 1 == 0)
          ? eval.toInt().toString()
          : result
              .replaceAll(RegExp(r"0*$"), "")
              .replaceAll(RegExp(r"\.$"), "");
    } catch (e) {
      return "Error";
    }
  }
}