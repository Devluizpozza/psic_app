import 'package:flutter/material.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';

class ScheduleButton extends StatelessWidget {
  final void Function()? onPressed;

  const ScheduleButton({this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.therapyGreen,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
        ),
        onPressed: onPressed,
        child: const Text(
          'Agendar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
