import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovoMedicamento extends StatefulWidget {
  const NovoMedicamento({super.key});

  @override
  State<NovoMedicamento> createState() => _NovoMedicamentoState();
}

class _NovoMedicamentoState extends State<NovoMedicamento> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final dosagemController = TextEditingController();
  final formaController = TextEditingController();
  final posologiaController = TextEditingController();
  final quantPrescritaController = TextEditingController();
  final quantDispensadaController = TextEditingController();
  final pinAcessoController = TextEditingController();
  final pinOpcaoController = TextEditingController();

  DateTime? validade;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicamento registrado com sucesso')),
      );
    }
  }

  Future<void> _selectValidade() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => validade = picked);
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedValidade = validade != null
        ? DateFormat('dd/MM/yyyy').format(validade!)
        : 'Selecionar data';

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: const Text('MEDITRACK'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Novo Medicamento',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildTextField('Nome', nomeController),
                      _buildTextField('Dosagem', dosagemController),
                      _buildTextField('Forma Farmacêutica', formaController),
                      _buildTextField('Posologia', posologiaController),
                      _buildTextField('Quantidade Prescrita', quantPrescritaController,
                          keyboard: TextInputType.number),
                      _buildTextField('Quantidade Dispensada', quantDispensadaController,
                          keyboard: TextInputType.number),
                      _buildTextField('PIN de Acesso', pinAcessoController,
                          obscure: true, keyboard: TextInputType.number),
                      _buildTextField('PIN de Opção', pinOpcaoController,
                          obscure: true, keyboard: TextInputType.number),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Validade', style: TextStyle(color: Colors.white70)),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: _selectValidade,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            formattedValidade,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
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
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
