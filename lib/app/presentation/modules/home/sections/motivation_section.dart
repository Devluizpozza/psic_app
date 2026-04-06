import 'package:flutter/material.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';

class MotivationSection extends StatelessWidget {
  const MotivationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.mentalEase.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hoje, vá no seu tempo 🌿',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          Text(
            'Você não precisa estar bem o tempo todo. '
            'Respire fundo, acolha o que sente agora e lembre-se: '
            'um passo de cada vez também é progresso.',
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
        ],
      ),
    );
  }
}
