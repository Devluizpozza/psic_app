import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Isso não é um diagnóstico.\n'
      'Essas informações servem apenas para ajudar no seu acolhimento inicial.',
      style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
    );
  }
}
