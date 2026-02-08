import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final Widget child;

  const InputContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: child,
      ),
    );
  }
}
