import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditrack/medicamento/edit_medicamento.dart';
import 'package:meditrack/medicamento/novo_medicamento.dart';
import 'package:meditrack/medicamento/funcoes_medicamento.dart';
import 'package:meditrack/model/medicamento_dto.dart';

class MedicamentosBrowse extends StatefulWidget {
  const MedicamentosBrowse({super.key});

  @override
  State<MedicamentosBrowse> createState() => _MedicamentosBrowseState();
}

class _MedicamentosBrowseState extends State<MedicamentosBrowse> {
  late Future<List<MedicamentoDTO>> _medicamentosFuture;

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
  }

  void _carregarMedicamentos() {
    _medicamentosFuture = _obterMedicamentosComUserId();
  }

  Future<List<MedicamentoDTO>> _obterMedicamentosComUserId() async {
    final userId = await obterUserIdDoToken(); // já vem de funcoes_medicamento.dart
    return await getAllMedicamento(userId);
  }

  void _recarregar() {
    setState(() {
      _carregarMedicamentos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hojeFormatado = DateFormat('dd/MM').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('MEDITRACK'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<MedicamentoDTO>>(
          future: _medicamentosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erro: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            final medicamentos = snapshot.data!;
            if (medicamentos.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum medicamento cadastrado.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: medicamentos.length,
              itemBuilder: (context, index) {
                final med = medicamentos[index];
                return MedicationCard(
                  label: med.descricao ?? 'Medicamento',
                  date: hojeFormatado,
                  currentDose: med.posologia ?? '-',
                  total: '${med.quantEmb}*${med.quantDispensada}',
                  onTap: () async {
                    final atualizado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditMedicamento(medicamento: med),
                      ),
                    );
                    if (atualizado == true) {
                      _recarregar();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final criado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NovoMedicamento(),
            ),
          );
          if (criado == true) {
            _recarregar();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final String label;
  final String date;
  final String currentDose;
  final String total;
  final VoidCallback onTap;

  const MedicationCard({
    super.key,
    required this.label,
    required this.date,
    required this.currentDose,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 18)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(date, style: const TextStyle(color: Colors.white)),
                Text(currentDose, style: const TextStyle(color: Colors.white)),
                Text(total, style: const TextStyle(color: Colors.white38)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
