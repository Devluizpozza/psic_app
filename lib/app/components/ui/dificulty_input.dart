import 'package:flutter/material.dart';
import 'package:psicApp/app/components/ui/input_container_ui.dart';

class DifficultyField extends StatelessWidget {
  final void Function(String) onChanged;

  const DifficultyField(this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Principal dificuldade',
          hintText: 'Se quiser, descreva com suas próprias palavras...',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
