import 'package:flutter/material.dart';
import 'package:meditrack/utilizador/funcoes_utilizador.dart'; // importa o criarPin

class CriarPinPage extends StatefulWidget {
  final String username;

  const CriarPinPage({super.key, required this.username});

  @override
  State<CriarPinPage> createState() => _CriarPinPageState();
}

class _CriarPinPageState extends State<CriarPinPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmacaoController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final pin = pinController.text;

      try {
        await criarPin(widget.username, pin); // chamada real
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN criado com sucesso')),
        );

        Navigator.pop(context); // ou redirecione para tela principal
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar PIN: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar PIN'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF1C1C1C),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPinField('PIN', pinController),
              const SizedBox(height: 16),
              _buildPinField('Confirmar PIN', confirmacaoController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submeter',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      maxLength: 6,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black54,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        counterText: '',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        if (value.length < 4) {
          return 'PIN deve ter no mínimo 4 dígitos';
        }
        if (label == 'Confirmar PIN' && value != pinController.text) {
          return 'PINs não coincidem';
        }
        return null;
      },
    );
  }
}
