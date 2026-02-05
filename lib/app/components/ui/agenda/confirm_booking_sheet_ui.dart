import 'package:estacionaqui/app/models/time_slot_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmBookingSheetUI extends StatelessWidget {
  final TimeSlot slot;
  final VoidCallback onConfirm;

  const ConfirmBookingSheetUI({
    super.key,
    required this.slot,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Confirmar consulta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(DateFormat('dd/MM/yyyy • HH:mm').format(slot.startAt)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onConfirm,
              child: const Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }
}
