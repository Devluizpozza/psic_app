import 'package:estacionaqui/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SoftBackgroundDecoration extends StatelessWidget {
  const SoftBackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.softMint.withOpacity(0.25),
                AppColors.mentalEase.withOpacity(0.15),
                AppColors.softPeach.withOpacity(0.12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
