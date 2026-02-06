import 'package:get/get.dart';
import 'package:psicApp/app/modules/agenda/agenda_controller.dart';

class AgendaBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgendaController>(() => AgendaController());
  }
}
