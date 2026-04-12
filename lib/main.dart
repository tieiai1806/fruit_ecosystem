import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/calculator/views/calculator_view.dart';
import 'app/modules/calculator/bindings/calculator_binding.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/calculator',
      getPages: [
        GetPage(
          name: '/calculator',
          page: () => const CalculatorView(),
          binding: CalculatorBinding(),
        ),
      ],
      theme: ThemeData(fontFamily: 'Roboto'),
    ),
  );
}