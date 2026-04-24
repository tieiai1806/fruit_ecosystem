import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/modules/calculator/screens/calculator_screen.dart';
import 'app/modules/calculator/providers/calculator_provider.dart';
import 'app/modules/calculator/providers/history_provider.dart'; // ✅ THÊM

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
        ChangeNotifierProvider(create: (_) => HistoryProvider()), // ✅ THÊM DÒNG NÀY
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fruit Ecosystem App',
        home: const CalculatorScreen(),
      ),
    );
  }
}