import 'package:flutter/material.dart';

class ModeSelector extends StatelessWidget {
  final VoidCallback onToggle;
  const ModeSelector({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.category),
      onPressed: onToggle,
    );
  }
}