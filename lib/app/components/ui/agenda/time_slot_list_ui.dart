import 'package:estacionaqui/app/components/ui/agenda/time_slot_tile_ui.dart';
import 'package:estacionaqui/app/models/time_slot_model.dart';
import 'package:flutter/material.dart';

class TimeSlotListUI extends StatelessWidget {
  final List<TimeSlot> slots;
  final Function(TimeSlot) onSelect;

  const TimeSlotListUI({
    super.key,
    required this.slots,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: slots.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return TimeSlotTileUI(
          slot: slots[index],
          onTap: () => onSelect(slots[index]),
        );
      },
    );
  }
}
