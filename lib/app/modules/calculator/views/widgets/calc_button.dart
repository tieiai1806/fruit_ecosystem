import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color mauChu;
  final VoidCallback onPressed;

  const CalcButton({
    super.key,
    required this.text,
    required this.bgColor,
    this.mauChu = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(22),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: mauChu,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}