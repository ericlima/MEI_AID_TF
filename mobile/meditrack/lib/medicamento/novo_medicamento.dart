import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditrack/model/medicamento_dto.dart';
import 'package:meditrack/medicamento/funcoes_medicamento.dart';

class NovoMedicamento extends StatefulWidget {
  const NovoMedicamento({super.key});

  @override
  State<NovoMedicamento> createState() => _NovoMedicamentoState();
}

class _NovoMedicamentoState extends State<NovoMedicamento> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController descricaoController;
  late TextEditingController posologiaController;
  late TextEditingController preditorController;
  late TextEditingController localController;
  late TextEditingController pinAcessoController;
  late TextEditingController pinOpcaoController;
  late TextEditingController quantEmbController;
  late TextEditingController quantDiaController;
  late TextEditingController quantPrescritaController;
  late TextEditingController quantDispensadaController;

  DateTime? inicio;
  DateTime? fim;

  @override
  void initState() {
    super.initState();
    descricaoController = TextEditingController();
    posologiaController = TextEditingController();
    preditorController = TextEditingController();
    localController = TextEditingController();
    pinAcessoController = TextEditingController();
    pinOpcaoController = TextEditingController();
    quantEmbController = TextEditingController();
    quantDiaController = TextEditingController();
    quantPrescritaController = TextEditingController();
    quantDispensadaController = TextEditingController();
    inicio = DateTime.now();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userId = await obterUserIdDoToken();

        final novo = MedicamentoDTO(
          userId: userId,
          descricao: descricaoController.text,
          posologia: posologiaController.text,
          preditor: preditorController.text,
          local: localController.text,
          inicio: inicio ?? DateTime.now(),
          fim: fim,
          pinacesso: pinAcessoController.text,
          pinopcao: pinOpcaoController.text,
          quantEmb: int.tryParse(quantEmbController.text),
          quantDia: int.tryParse(quantDiaController.text),
          quantPrescrita: int.tryParse(quantPrescritaController.text),
          quantDispensada: int.tryParse(quantDispensadaController.text),
        );

        await inserirMedicamento(novo);

        if (!mounted) return;
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao inserir: $e')),
        );
      }
    }
  }

  Future<void> _selectDate({
    required DateTime? initialDate,
    required void Function(DateTime) onDateSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
    );
    if (picked != null) {
      setState(() => onDateSelected(picked));
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboard,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? date, void Function(DateTime) onSelect) {
    final formatted = date != null ? DateFormat('dd/MM/yyyy').format(date) : 'Selecionar data';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _selectDate(initialDate: date, onDateSelected: onSelect),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              formatted,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: const Text('Novo Medicamento'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Cadastrar Medicamento',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField('Descrição', descricaoController),
                _buildTextField('Posologia', posologiaController),
                _buildTextField('Preditor', preditorController),
                _buildTextField('Local', localController),
                _buildTextField('PIN de Acesso', pinAcessoController,
                    keyboard: TextInputType.number),
                _buildTextField('PIN de Opção', pinOpcaoController,
                    keyboard: TextInputType.number),
                _buildTextField('Quant. Embalagem', quantEmbController,
                    keyboard: TextInputType.number),
                _buildTextField('Quant. por Dia', quantDiaController,
                    keyboard: TextInputType.number),
                _buildTextField('Quant. Prescrita', quantPrescritaController,
                    keyboard: TextInputType.number),
                _buildTextField('Quant. Dispensada', quantDispensadaController,
                    keyboard: TextInputType.number),
                _buildDateField('Início', inicio, (d) => inicio = d),
                _buildDateField('Fim', fim, (d) => fim = d),
                const SizedBox(height: 8),
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
                      'Salvar Medicamento',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
