import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:psicApp/app/presentation/modules/auth/register/register_user_controller.dart';
import 'package:psicApp/app/core/theme/app_colors.dart';

class RegisterUserView extends GetView<RegisterUserController> {
  const RegisterUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneMask = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Criar Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildField(
                label: "Nome completo",
                fieldController: controller.nameController,
                validator: controller.validateName,
                keyboardType: TextInputType.name,
              ),
              _buildField(
                label: "E-mail",
                fieldController: controller.emailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildField(
                label: "(00) 00000-0000",
                fieldController: controller.contatoController,
                validator: controller.validatePhone,
                keyboardType: TextInputType.phone,
                inputFormatters: [phoneMask],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: () => controller.createUser(),
          child: const Icon(Icons.arrow_forward, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController fieldController,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    List<dynamic> inputFormatters = const [],
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: fieldController,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters.cast(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey[200]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
