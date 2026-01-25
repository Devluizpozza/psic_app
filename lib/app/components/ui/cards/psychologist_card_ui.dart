import 'package:estacionaqui/app/models/psychologist_model.dart';
import 'package:estacionaqui/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PsychologistCard extends StatelessWidget {
  final Psychologist psychologist;

  const PsychologistCard({super.key, required this.psychologist});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              circleAvatar(),
              const SizedBox(width: 16),
              Expanded(child: infoPsyc()),
            ],
          ),
          Positioned(bottom: 4, right: 4, child: verifyIcon()),
        ],
      ),
    );
  }

  Widget circleAvatar() {
    return CircleAvatar(
      radius: 30,
      backgroundColor: AppColors.mentalEase.withOpacity(0.3),
      backgroundImage: const NetworkImage(
        'https://images.unsplash.com/photo-1537368910025-700350fe46c7',
      ),
    );
  }

  Widget infoPsyc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          psychologist.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          psychologist.contact,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 10),
        Chip(
          label: Text(psychologist.specialty.name),
          backgroundColor: AppColors.softMint.withOpacity(0.35),
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }

  Widget verifyIcon() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check, size: 12, color: Colors.white),
    );
  }
}
