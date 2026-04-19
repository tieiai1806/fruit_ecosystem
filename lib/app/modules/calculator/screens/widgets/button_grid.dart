import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/calculator_provider.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  final List<String> buttons;
  final int crossAxisCount;

  const ButtonGrid({super.key, required this.buttons, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.2, // Tỷ lệ nút bấm
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return CalculatorButton(
          label: buttons[index],
          onTap: () {
            // Xử lý sự kiện tùy theo nhãn nút
            context.read<CalculatorProvider>().appendValue(buttons[index]);
          },
        );
      },
    );
  }
}