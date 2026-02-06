import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psicApp/app/models/time_slot_model.dart';

class TimeSlotTileUI extends StatelessWidget {
  final TimeSlot slot;
  final VoidCallback onTap;

  const TimeSlotTileUI({super.key, required this.slot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final time =
        '${DateFormat.Hm().format(slot.startAt)} - ${DateFormat.Hm().format(slot.endAt)}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            time,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
