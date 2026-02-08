import 'package:flutter/material.dart';
import 'package:psicApp/app/models/time_slot_model.dart';
import 'package:psicApp/app/utils/app_colors.dart';

class TimeSlotCardui extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool selected;
  final Color selectedColor;
  final VoidCallback? onTap;

  const TimeSlotCardui({
    super.key,
    required this.timeSlot,
    this.selected = false,
    this.selectedColor = AppColors.softMint,
    this.onTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF8FBFAF) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                '${format(timeSlot.startAt)} - ${format(timeSlot.endAt)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ),
            if (selected)
              Positioned(
                bottom: 4,
                right: 4,
                child: AnimatedOpacity(
                  opacity: selected ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.check_circle, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String formatHourMinute(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String format(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  // Widget infoPsyc() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         psychologist.name,
  //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //       ),
  //       const SizedBox(height: 6),
  //       Text(
  //         psychologist.contact,
  //         style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
  //       ),
  //       const SizedBox(height: 10),
  //       Chip(
  //         label: Text(psychologist.specialty.name),
  //         backgroundColor: AppColors.softMint.withOpacity(0.35),
  //         labelStyle: const TextStyle(
  //           fontSize: 13,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
