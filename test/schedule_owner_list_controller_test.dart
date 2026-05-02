import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';
import 'package:psicApp/app/data/repositories/time_slot_repository.dart';
import 'package:psicApp/app/domain/models/app_user.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';
import 'package:psicApp/app/presentation/modules/schedule/schedule_owner_list_controller.dart';
import 'package:psicApp/app/presentation/shared/controllers/user_controller.dart';

// ── Fake do repositório — não toca no Firestore ──────────────────────────────

class FakeTimeSlotRepository extends TimeSlotRepository {
  final List<TimeSlot> _stored;

  final List<TimeSlot> createdSlots = [];
  final List<String> deletedIds = [];

  bool failOnCreate = false;
  bool failOnDelete = false;

  FakeTimeSlotRepository({List<TimeSlot>? initialSlots})
      : _stored = initialSlots ?? [];

  @override
  Future<List<TimeSlot>> listByPsychologistId(String psychologistId) async =>
      List.of(_stored);

  @override
  Future<bool> create(String psychologistId, TimeSlot timeSlot) async {
    if (failOnCreate) return false;
    createdSlots.add(timeSlot);
    return true;
  }

  @override
  Future<bool> delete(String psychologistId, String timeSlotId) async {
    if (failOnDelete) return false;
    deletedIds.add(timeSlotId);
    return true;
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

const _psychologistId = 'psych-uid-123';

TimeSlot _makeSlot({required int hour, String? uid, bool isAvailable = true}) {
  final start = DateTime(2026, 5, 10, hour);
  return TimeSlot(
    uid: uid ?? 'slot-$hour',
    psychologistId: _psychologistId,
    startAt: start,
    endAt: start.add(const Duration(hours: 1)),
    isAvailable: isAvailable,
  );
}

ScheduleOwnerListController _buildController({
  FakeTimeSlotRepository? repo,
}) {
  final controller = ScheduleOwnerListController(repo: repo ?? FakeTimeSlotRepository());
  // Seleciona a data fixa para os testes não dependerem do dia atual
  controller.selectedDate.value = DateTime(2026, 5, 10);
  return controller;
}

// ── Setup e teardown ──────────────────────────────────────────────────────────

void main() {
  setUp(() {
    Get.testMode = true;
    // Registra um UserController com usuário fake pré-configurado
    final userCtrl = UserController();
    userCtrl.user = AppUser(
      uid: _psychologistId,
      name: 'Dr. Teste',
      contato: '',
      email: 'dr@teste.com',
      userType: UserRoleType.psychologist,
      onboardingStepType: OnboardingStepType.finished,
      createAt: DateTime(2026, 1, 1),
    );
    Get.put(userCtrl);
  });

  tearDown(() => Get.reset());

  // ── addTimeSlot ─────────────────────────────────────────────────────────────

  group('addTimeSlot', () {
    test('adiciona slot localmente sem chamar o repositório', () async {
      final repo = FakeTimeSlotRepository();
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(9);

      expect(ctrl.timeSlots.length, 1);
      expect(ctrl.timeSlots.first.startAt.hour, 9);
      expect(repo.createdSlots, isEmpty, reason: 'não deve ter ido ao banco');
      expect(ctrl.hasPendingChanges, isTrue);
    });

    test('não permite adicionar o mesmo horário duas vezes no mesmo dia', () async {
      final ctrl = _buildController();
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(10);
      ctrl.addTimeSlot(10);

      expect(ctrl.timeSlots.length, 1);
    });

    test('lista fica ordenada após múltiplas adições fora de ordem', () async {
      final ctrl = _buildController();
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(14);
      ctrl.addTimeSlot(9);
      ctrl.addTimeSlot(11);

      final hours = ctrl.timeSlots.map((s) => s.startAt.hour).toList();
      expect(hours, [9, 11, 14]);
    });
  });

  // ── removeTimeSlot ──────────────────────────────────────────────────────────

  group('removeTimeSlot', () {
    test('remove slot pendente localmente sem enfileirar para delete', () async {
      final repo = FakeTimeSlotRepository();
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(8);
      final slot = ctrl.timeSlots.first;

      ctrl.removeTimeSlot(slot);

      expect(ctrl.timeSlots, isEmpty);
      expect(repo.deletedIds, isEmpty, reason: 'era pendente, não deve deletar no banco');
      expect(ctrl.hasPendingChanges, isFalse);
    });

    test('remove slot existente no banco e enfileira para delete', () async {
      final existing = _makeSlot(hour: 10, uid: 'existing-slot');
      final repo = FakeTimeSlotRepository(initialSlots: [existing]);
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.removeTimeSlot(existing);

      expect(ctrl.timeSlots, isEmpty);
      expect(ctrl.hasPendingChanges, isTrue);
    });

    test('não permite remover slot já agendado (isAvailable = false)', () async {
      final booked = _makeSlot(hour: 15, isAvailable: false);
      final repo = FakeTimeSlotRepository(initialSlots: [booked]);
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.removeTimeSlot(booked);

      expect(ctrl.timeSlots.length, 1, reason: 'slot agendado não deve ser removido');
    });
  });

  // ── saveChanges ─────────────────────────────────────────────────────────────

  group('saveChanges', () {
    test('persiste adições e deleções em paralelo e limpa pendências', () async {
      final existing = _makeSlot(hour: 8, uid: 'slot-existente');
      final repo = FakeTimeSlotRepository(initialSlots: [existing]);
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      // Remove o existente e adiciona dois novos
      ctrl.removeTimeSlot(existing);
      ctrl.addTimeSlot(10);
      ctrl.addTimeSlot(11);

      expect(ctrl.hasPendingChanges, isTrue);

      await ctrl.saveChanges();

      expect(repo.createdSlots.length, 2, reason: 'deve criar os 2 novos');
      expect(repo.deletedIds, contains('slot-existente'), reason: 'deve deletar o removido');
      expect(ctrl.hasPendingChanges, isFalse, reason: 'pendências limpas após salvar');
    });

    test('não faz chamada ao banco se não há mudanças', () async {
      final repo = FakeTimeSlotRepository();
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      await ctrl.saveChanges();

      expect(repo.createdSlots, isEmpty);
      expect(repo.deletedIds, isEmpty);
    });

    test('mantém isSaving false após salvar com sucesso', () async {
      final repo = FakeTimeSlotRepository();
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(9);
      await ctrl.saveChanges();

      expect(ctrl.isSaving.value, isFalse);
    });

    test('mantém hasPendingChanges true se create falhar', () async {
      final repo = FakeTimeSlotRepository()..failOnCreate = true;
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(9);

      await ctrl.saveChanges();

      // O create falhou — as pendências NÃO devem ser limpas
      expect(ctrl.hasPendingChanges, isTrue);
    });
  });

  // ── hasPendingChanges ───────────────────────────────────────────────────────

  group('hasPendingChanges', () {
    test('começa false após fetch', () async {
      final ctrl = _buildController();
      await ctrl.fetchTimeSlots();
      expect(ctrl.hasPendingChanges, isFalse);
    });

    test('volta para false após salvar com sucesso', () async {
      final repo = FakeTimeSlotRepository();
      final ctrl = _buildController(repo: repo);
      await ctrl.fetchTimeSlots();

      ctrl.addTimeSlot(13);
      expect(ctrl.hasPendingChanges, isTrue);

      await ctrl.saveChanges();
      expect(ctrl.hasPendingChanges, isFalse);
    });
  });
}
