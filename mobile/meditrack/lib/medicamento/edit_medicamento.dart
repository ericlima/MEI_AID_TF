import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditMedicamento extends StatefulWidget {
  final String label;
  final String date;
  final String currentDose;
  final String total;

  const EditMedicamento({
    super.key,
    required this.label,
    required this.date,
    required this.currentDose,
    required this.total,
  });

  @override
  State<EditMedicamento> createState() => _EditMedicamentoState();
}

class _EditMedicamentoState extends State<EditMedicamento> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nomeController;
  late TextEditingController dosagemController;
  late TextEditingController formaController;
  late TextEditingController posologiaController;
  late TextEditingController quantPrescritaController;
  late TextEditingController quantDispensadaController;
  late TextEditingController pinAcessoController;
  late TextEditingController pinOpcaoController;

  DateTime? validade;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: 'Nome exemplo');
    dosagemController = TextEditingController(text: '10mg');
    formaController = TextEditingController(text: 'Comprimido');
    posologiaController = TextEditingController(text: '1x ao dia');
    quantPrescritaController = TextEditingController(text: '8');
    quantDispensadaController = TextEditingController(text: '8');
    pinAcessoController = TextEditingController();
    pinOpcaoController = TextEditingController();
    validade = DateTime.now().add(const Duration(days: 30));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alterações salvas com sucesso')),
      );
    }
  }

  Future<void> _selectValidade() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: validade ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
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
                        'Editar Medicamento',
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
                            'Salvar Alterações',
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
