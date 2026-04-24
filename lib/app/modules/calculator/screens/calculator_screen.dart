import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'widgets/calculator_button.dart';
import '../../../modules/calculator/providers/history_provider.dart';
import '../../../modules/calculator/screens/history_screen.dart';
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
    'exp', 'sin', 'cos', 'tan', 'Ln', 'log',
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
          // NÚT XEM LỊCH SỬ
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          // NÚT CÀI ĐẶT
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
              // 1. DISPLAY AREA
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            controller: provider.expressionController,
                            readOnly: true,
                            showCursor: true,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(border: InputBorder.none),
                            style: const TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                        ),
                      ),
                      Text(
                        provider.result,
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. BACKSPACE BUTTON (Hàng riêng)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 80,
                    height: 50,
                    child: CalculatorButton(
                      label: '⌫',
                      onTap: () => provider.backspace(),
                    ),
                  ),
                ),
              ),

              // 3. GRID LAYOUT
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
                      // CHỈ đoạn onTap cần sửa 👇

onTap: () {
  if (label == '=') {
    provider.calculate(context);
  } else if (label == 'C') {
    provider.clear();
  } else if (label == 'CE') {
    provider.clearEntry(); // ✅ FIX
  } else if (['sin', 'cos', 'tan', 'log', 'Ln', '√', 'exp'].contains(label)) {
    provider.addScientificFunction(label);
  } else if (label == 'x^y') {
    provider.addScientificFunction('x^y');
  } else if (label == 'Π') {
    provider.appendValue('Π');
  } else {
    provider.appendValue(label);
  }
}
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