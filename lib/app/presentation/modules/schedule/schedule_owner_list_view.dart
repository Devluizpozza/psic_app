import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';
import 'package:psicApp/app/domain/models/time_slot.dart';
import 'package:psicApp/app/presentation/modules/schedule/schedule_owner_list_controller.dart';

class ScheduleOwnerListView extends GetView<ScheduleOwnerListController> {
  const ScheduleOwnerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.therapyGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Meus Horários',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.therapyGreen),
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          children: [
            _DateSelector(controller: controller),
            const SizedBox(height: 24),
            _HourGrid(controller: controller),
            const SizedBox(height: 24),
            _TimeSlotList(controller: controller),
            // Espaço para o FAB não sobrepor o último item
            const SizedBox(height: 80),
          ],
        );
      }),
      floatingActionButton: Obx(() {
        final hasPending = controller.hasPendingChanges;
        final isSaving = controller.isSaving.value;

        if (!hasPending && !isSaving) return const SizedBox.shrink();

        return FloatingActionButton.extended(
          onPressed: isSaving ? null : controller.saveChanges,
          backgroundColor: AppColors.therapyGreen,
          foregroundColor: Colors.white,
          elevation: 4,
          icon: isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.check_rounded),
          label: Text(
            isSaving ? 'Salvando...' : 'Salvar horários',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      }),
    );
  }
}

// ── Seletor de data ──────────────────────────────────────────────────────────

class _DateSelector extends StatelessWidget {
  final ScheduleOwnerListController controller;
  const _DateSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final date = controller.selectedDate.value;
      final formatted = DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(date);

      return GestureDetector(
        onTap: () => controller.selectDate(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.therapyGreen.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.therapyGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.therapyGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data selecionada',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatted,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ── Grade de horários disponíveis ────────────────────────────────────────────

class _HourGrid extends StatelessWidget {
  final ScheduleOwnerListController controller;
  const _HourGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Adicionar horário',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Toque em um horário para adicioná-lo à sua agenda',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Obx(() {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.availableHours.map((hour) {
              final isAdded = controller.isHourAdded(hour);
              final startLabel =
                  '${hour.toString().padLeft(2, '0')}:00';
              final endLabel =
                  '${(hour + 1).toString().padLeft(2, '0')}:00';

              return GestureDetector(
                onTap: isAdded ? null : () => controller.addTimeSlot(hour),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isAdded
                        ? AppColors.therapyGreen.withOpacity(0.15)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isAdded
                          ? AppColors.therapyGreen
                          : Colors.grey.shade300,
                      width: isAdded ? 1.5 : 1,
                    ),
                    boxShadow: isAdded
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isAdded
                            ? Icons.check_circle_rounded
                            : Icons.access_time_rounded,
                        size: 14,
                        color: isAdded
                            ? AppColors.therapyGreen
                            : Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$startLabel - $endLabel',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isAdded
                              ? AppColors.therapyGreen
                              : const Color(0xFF4A5568),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}

// ── Lista de horários criados ────────────────────────────────────────────────

class _TimeSlotList extends StatelessWidget {
  final ScheduleOwnerListController controller;
  const _TimeSlotList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final slots = controller.timeSlots;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Todos os horários',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.therapyGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${slots.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (slots.isEmpty)
            _EmptyState()
          else
            ...slots.map((slot) => _TimeSlotCard(
                  slot: slot,
                  onDelete: () => controller.removeTimeSlot(slot),
                )),
        ],
      );
    });
  }
}

class _TimeSlotCard extends StatelessWidget {
  final TimeSlot slot;
  final VoidCallback onDelete;

  const _TimeSlotCard({required this.slot, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final startLabel = DateFormat('HH:mm').format(slot.startAt);
    final endLabel = DateFormat('HH:mm').format(slot.endAt);
    final dateLabel = DateFormat("d MMM", 'pt_BR').format(slot.startAt);
    final isBooked = !slot.isAvailable;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: isBooked ? AppColors.softPeach : AppColors.therapyGreen,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$startLabel - $endLabel',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3748),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 12,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isBooked
                            ? AppColors.softPeach.withOpacity(0.3)
                            : AppColors.therapyGreen.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isBooked ? 'Agendado' : 'Disponível',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isBooked
                              ? Colors.deepOrange.shade400
                              : AppColors.therapyGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isBooked)
            GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: Colors.red.shade400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 52,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            'Nenhum horário criado',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Selecione um dia e toque em um horário acima',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
