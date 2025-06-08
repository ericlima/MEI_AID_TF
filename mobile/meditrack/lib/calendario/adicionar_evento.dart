import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditrack/calendario/funcoes_calendario.dart';
import 'package:meditrack/model/agenda_dto.dart';

class AdicionarEventoPage extends StatefulWidget {
  final DateTime date;

  const AdicionarEventoPage({super.key, required this.date});

  @override
  State<AdicionarEventoPage> createState() => _AdicionarEventoPageState();
}

class _AdicionarEventoPageState extends State<AdicionarEventoPage> {
  final _descricaoController = TextEditingController();
  final _localController = TextEditingController();
  final _observacoesController = TextEditingController();

  DateTime? _dataInicio;
  TimeOfDay? _horaInicio;
  DateTime? _dataFim;
  TimeOfDay? _horaFim;
  bool _diaInteiro = false;

  @override
  void initState() {
    super.initState();
    _dataInicio = widget.date;
    _dataFim = widget.date;
  }

  Future<void> _selecionarData(BuildContext context, bool isInicio) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isInicio ? _dataInicio! : _dataFim!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
    );
    if (picked != null) {
      setState(() {
        if (isInicio) {
          _dataInicio = picked;
        } else {
          _dataFim = picked;
        }
      });
    }
  }

  Future<void> _selecionarHora(BuildContext context, bool isInicio) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
    );
    if (picked != null) {
      setState(() {
        if (isInicio) {
          _horaInicio = picked;
        } else {
          _horaFim = picked;
        }
      });
    }
  }

  Future<void> _salvarEvento() async {
    final titulo = _descricaoController.text.trim();
    final local = _localController.text.trim();
    final notas = _observacoesController.text.trim();

    if (titulo.isEmpty || _dataInicio == null || _dataFim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os campos obrigatórios')),
      );
      return;
    }

    DateTime inicio = _dataInicio!;
    DateTime? fim = _dataFim;

    if (!_diaInteiro) {
      if (_horaInicio != null) {
        inicio = DateTime(
          _dataInicio!.year,
          _dataInicio!.month,
          _dataInicio!.day,
          _horaInicio!.hour,
          _horaInicio!.minute,
        );
      }
      if (_horaFim != null) {
        fim = DateTime(
          _dataFim!.year,
          _dataFim!.month,
          _dataFim!.day,
          _horaFim!.hour,
          _horaFim!.minute,
        );
      }
    }

    final agenda = AgendaDTO(
      id: 0,
      userId: 0, // será preenchido no inserirAgenda
      inicio: inicio,
      fim: fim,
      titulo: titulo,
      local: local,
      diaInteiro: _diaInteiro,
      recorrenciaRrle: null,
      notas: notas.isEmpty ? null : notas,
    );

    try {
      await inserirAgenda(agenda);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento salvo com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }

  String _formatarData(DateTime? data) =>
      data != null ? DateFormat('dd/MM/yyyy').format(data) : 'Selecionar data';

  String _formatarHora(TimeOfDay? hora) =>
      hora != null ? hora.format(context) : 'Selecionar hora';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: const Text('Novo Evento'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTextField('Descrição *', _descricaoController),
            _buildTextField('Local', _localController),
            const SizedBox(height: 20),
            _buildDateTimeRow('Data de Início *', _formatarData(_dataInicio),
                () => _selecionarData(context, true)),
            if (!_diaInteiro)
              _buildDateTimeRow('Hora de Início', _formatarHora(_horaInicio),
                  () => _selecionarHora(context, true)),
            const SizedBox(height: 16),
            _buildDateTimeRow('Data de Fim *', _formatarData(_dataFim),
                () => _selecionarData(context, false)),
            if (!_diaInteiro)
              _buildDateTimeRow('Hora de Fim', _formatarHora(_horaFim),
                  () => _selecionarHora(context, false)),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _diaInteiro,
              onChanged: (val) => setState(() => _diaInteiro = val!),
              title: const Text('Dia inteiro', style: TextStyle(color: Colors.white)),
              activeColor: Colors.teal,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            _buildTextField('Observações', _observacoesController, maxLines: 3),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _salvarEvento,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              icon: const Icon(Icons.check),
              label: const Text('Salvar Evento'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black54,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDateTimeRow(String label, String value, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(value, style: const TextStyle(color: Colors.tealAccent)),
          ),
        ],
      ),
    );
  }
}
