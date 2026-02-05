import 'package:estacionaqui/app/modules/agenda/agenda_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AgendaView extends GetView<AgendaController> {
  const AgendaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar consulta')),
      body: Column(
        children: [
          // DaySelectorUI(
          //   onDaySelected: controller.selectDay,
          //   selectedDay: DateTime.now(),
          //   availableDays: controller.availableDays,
          // ),
          const Divider(),
          Expanded(
            child: Text(""),
            // if (1 == false) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            // const Center(child: Text('Nenhum horário disponível'));
            // TimeSlotListUI(slots: controller.slots, onSelect: (timeSlot) => {}),
          ),
        ],
      ),
    );
  }
}
