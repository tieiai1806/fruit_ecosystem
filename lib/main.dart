import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Sau khi chạy lệnh add, dòng này sẽ hết lỗi

import 'app/modules/calculator/screens/calculator_screen.dart';
import 'app/modules/calculator/providers/calculator_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fruit Ecosystem App',
        home: const CalculatorScreen(), 
      ),
    );
  }
}