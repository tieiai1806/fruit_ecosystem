import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../modules/calculator/providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Lịch sử tính toán"),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: () => context.read<HistoryProvider>().clearHistory(),
        )
      ],
    ),
    body: FutureBuilder(
      future: context.read<HistoryProvider>().loadHistory(),
      builder: (context, snapshot) {
        return Consumer<HistoryProvider>(
          builder: (context, provider, child) {
            if (provider.history.isEmpty) {
              return const Center(child: Text("Chưa có lịch sử nào"));
            }
            return ListView.builder(
              itemCount: provider.history.length,
              itemBuilder: (context, index) {
                final record = provider.history[index];
                return ListTile(
                  title: Text(record.expression, textAlign: TextAlign.right),
                  subtitle: Text(
                    "= ${record.result}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          },
        );
      },
    ),
  );
}
}
