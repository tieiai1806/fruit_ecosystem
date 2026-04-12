import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/core/values/app_colors.dart';
import '../controllers/calculator_controller.dart';
import 'widgets/calc_button.dart';

class CalculatorView extends GetView<CalculatorController> {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(30),
                alignment: Alignment.bottomRight,
                child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.bieuThuc.value,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white60,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        controller.display.value,
                        style: const TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
            
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _taoHangNut(["C", "()", "%", "÷"]),
                    _taoHangNut(["7", "8", "9", "×"]),
                    _taoHangNut(["4", "5", "6", "-"]),
                    _taoHangNut(["1", "2", "3", "+"]),
                    _taoHangNut(["+/-", "0", ".", "="]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taoHangNut(List<String> danhSachNut) {
    return Expanded(
      child: Row(
        children: danhSachNut.map((tenNut) {
          return Obx(() {
            Color mauNut = AppColors.btnNumber;
            
            if (controller.phepTinhDangChon.value == tenNut) {
              mauNut = const Color.fromARGB(255, 188, 195, 189);
            } 
            else if (tenNut == "=") {
              mauNut = AppColors.btnEqual;
            } 
            else if (tenNut == "C") {
              mauNut = AppColors.btnClear;
            }

            return CalcButton(
              text: tenNut,
              bgColor: mauNut,
              onPressed: () => controller.nutBam(tenNut),
            );
          });
        }).toList(),
      ),
    );
  }
}