import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditrack/model/agenda_dto.dart';
import 'package:meditrack/calendario/funcoes_calendario.dart';

class AlterarEventoPage extends StatefulWidget {
  final AgendaDTO evento;

  const AlterarEventoPage({super.key, required this.evento});

  @override
  State<AlterarEventoPage> createState() => _AlterarEventoPageState();
}

class _AlterarEventoPageState extends State<AlterarEventoPage> {
  late TextEditingController _descricaoController;
  late TextEditingController _localController;
  late TextEditingController _observacoesController;

  DateTime? _dataInicio;
  TimeOfDay? _horaInicio;
  DateTime? _dataFim;
  TimeOfDay? _horaFim;
  bool _diaInteiro = false;

  @override
  void initState() {
    super.initState();

    _descricaoController = TextEditingController(text: widget.evento.titulo);
    _localController = TextEditingController(text: widget.evento.local);
    _observacoesController = TextEditingController(text: widget.evento.notas ?? '');

    _dataInicio = widget.evento.inicio;
    _dataFim = widget.evento.fim ?? widget.evento.inicio;

    _diaInteiro = widget.evento.diaInteiro;

    if (!_diaInteiro) {
      _horaInicio = TimeOfDay.fromDateTime(widget.evento.inicio);
      if (widget.evento.fim != null) {
        _horaFim = TimeOfDay.fromDateTime(widget.evento.fim!);
      }
    }
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

  Future<void> _atualizarEvento() async {
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

    final agendaAtualizada = AgendaDTO(
      id: widget.evento.id,
      userId: widget.evento.userId,
      inicio: inicio,
      fim: fim,
      titulo: titulo,
      local: local,
      diaInteiro: _diaInteiro,
      recorrenciaRrle: widget.evento.recorrenciaRrle,
      notas: notas.isEmpty ? null : notas,
    );

    try {
      await atualizarAgenda(agendaAtualizada);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alterações salvas com sucesso!')),
      );
      Navigator.pop(context, true); // Informa sucesso ao voltar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar alterações: $e')),
      );
    }
  }

  Future<void> _confirmarExclusao() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text('Confirmar exclusão', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Deseja realmente excluir este evento?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await _excluirEvento();
    }
  }

  Future<void> _excluirEvento() async {
    try {
      await excluirAgenda(widget.evento.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento excluído com sucesso')),
      );
      Navigator.pop(context, true); // Informa exclusão ao voltar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir: $e')),
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
        title: const Text('Alterar Evento'),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: _atualizarEvento,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Alterações'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _confirmarExclusao,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir Evento'),
                ),
              ],
            )
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
