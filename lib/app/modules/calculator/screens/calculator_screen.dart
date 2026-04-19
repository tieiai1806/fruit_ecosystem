import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'widgets/calculator_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  final List<String> basicButtons = const [
    'C', 'CE', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '±', '0', '.', '='
  ];

  final List<String> scientificButtons = const [
    '2nd', 'sin', 'cos', 'tan', 'Ln', 'log',
    'x^2', '√', 'x^y', '(', ')', '÷',
    'MC', '7', '8', '9', 'C', '×',
    'MR', '4', '5', '6', 'CE', '-',
    'M+', '1', '2', '3', '%', '+',
    'M-', '±', '0', '.', 'Π', '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_applications),
            onPressed: () => context.read<CalculatorProvider>().toggleMode(),
          )
        ],
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          final isScientific = provider.mode == CalculatorMode.scientific;
          final currentButtons = isScientific ? scientificButtons : basicButtons;
          final columns = isScientific ? 6 : 4;

          return Column(
            children: [
              // Display Area
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(provider.expression, style: const TextStyle(fontSize: 24, color: Colors.grey)),
                      Text(provider.result, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              
              // Grid Layout
              Expanded(
                flex: 2,
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: isScientific ? 0.9 : 1.2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: currentButtons.length,
                  itemBuilder: (context, index) {
                    final label = currentButtons[index];
                    return CalculatorButton(
                      label: label,
                      onTap: () {
                        // Logic phân loại nút bấm
                        if (label == '=') provider.calculate();
                        else if (label == 'C') provider.clear();
                        else if (['sin', 'cos', 'tan', 'log', 'Ln'].contains(label)) {
                          provider.addScientificFunction(label);
                        } else {
                          provider.appendValue(label);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}