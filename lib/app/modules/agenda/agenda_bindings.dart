import 'package:estacionaqui/app/modules/agenda/agenda_controller.dart';
import 'package:get/get.dart';

class AgendaBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgendaController>(() => AgendaController());
  }
}
