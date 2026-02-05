import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaySelectorUI extends StatelessWidget {
  final DateTime selectedDay;
  final Set<DateTime> availableDays;
  final ValueChanged<DateTime> onDaySelected;

  const DaySelectorUI({
    super.key,
    required this.selectedDay,
    required this.availableDays,
    required this.onDaySelected,
  });

  bool _isAvailable(DateTime day) {
    return availableDays.any(
      (availableDay) => DateUtils.isSameDay(availableDay, day),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 22,
        itemBuilder: (_, index) {
          final day = today.add(Duration(days: index));
          final isSelected = DateUtils.isSameDay(day, selectedDay);
          final isEnabled = _isAvailable(day);

          return GestureDetector(
            onTap: isEnabled ? () => onDaySelected(day) : null,
            child: Opacity(
              opacity: isEnabled ? 1 : 0.4,
              child: Container(
                width: 60,
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.E().format(day),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.day.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
