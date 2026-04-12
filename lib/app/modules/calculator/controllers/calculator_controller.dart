import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var display = '0'.obs;
  var bieuThuc = ''.obs;
  var phepTinhDangChon = ''.obs;
  bool vuaBamBang = false;

  String dinhDangSo(double so) {
    if (so.isInfinite || so.isNaN) return "Error";
    if (so % 1 == 0) return so.toInt().toString();
    String chuoi = so.toString();
    if (chuoi.length > 15) {
      chuoi = so.toStringAsFixed(10);
      while (chuoi.endsWith("0")) {
        chuoi = chuoi.substring(0, chuoi.length - 1);
      }
      if (chuoi.endsWith(".")) {
        chuoi = chuoi.substring(0, chuoi.length - 1);
      }
    }
    return chuoi;
  }

  void nutBam(String giaTriNhap) {
    if ("0123456789.".contains(giaTriNhap)) {
      if (display.value == "0" || vuaBamBang) {
        display.value = giaTriNhap;
        vuaBamBang = false;
      } else {
        display.value = "${display.value}$giaTriNhap";
      }
    } 
    else if (giaTriNhap == "C") {
      display.value = "0";
      bieuThuc.value = "";
      phepTinhDangChon.value = "";
      vuaBamBang = false;
    } 
    else if (giaTriNhap == "()") {
      if (vuaBamBang) {
        display.value = "(";
        vuaBamBang = false;
        return;
      }
      
      // Logic dấu ngoặc thông minh: 
      // Nếu số lượng dấu '(' đang nhiều hơn ')', thì bấm sẽ ra ')'. Ngược lại ra '('
      int countOpen = '('.allMatches(display.value).length;
      int countClose = ')'.allMatches(display.value).length;

      if (display.value == "0") {
        display.value = "(";
      } else if (countOpen > countClose && !" + - × ÷ (".contains(display.value.substring(display.value.length - 1))) {
        display.value = "${display.value})";
      } else {
        display.value = "${display.value}(";
      }
    }
    else if (giaTriNhap == "%") {
      try {
        double val = double.parse(display.value);
        display.value = dinhDangSo(val / 100);
      } catch (e) {}
    }
    else if ("+-×÷".contains(giaTriNhap)) {
      vuaBamBang = false;
      phepTinhDangChon.value = giaTriNhap;
      display.value = "${display.value}$giaTriNhap";
    } 
    else if (giaTriNhap == "=") {
      if (display.value != "0") {
        bieuThuc.value = "${display.value} =";
        
        try {
          // Chuẩn hóa chuỗi trước khi đưa vào thư viện
          String input = display.value.replaceAll('×', '*').replaceAll('÷', '/');
          
          Parser p = Parser();
          Expression exp = p.parse(input);
          ContextModel cm = ContextModel();
          double evaluation = exp.evaluate(EvaluationType.REAL, cm);
          
          display.value = dinhDangSo(evaluation);
        } catch (e) {
          display.value = "Error";
        }
        
        vuaBamBang = true;
        phepTinhDangChon.value = "";
      }
    }
    else if (giaTriNhap == "+/-") {
      if (display.value != "0" && !vuaBamBang) {
        if (display.value.startsWith("-")) {
          display.value = display.value.substring(1);
        } else {
          display.value = "-${display.value}";
        }
      }
    }
  }
}