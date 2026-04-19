import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const CalculatorButton({
    super.key, 
    required this.label, 
    required this.onTap, 
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}