import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'novo_medicamento.dart';
import 'edit_medicamento.dart'; // Novo import

class MedicamentosBrowse extends StatelessWidget {
  const MedicamentosBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dataFormatada = DateFormat('dd/MM').format(today);

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
        child: ListView(
          children: [
            MedicationCard(
              label: 'Data',
              date: dataFormatada,
              currentDose: '1',
              total: '1/8',
            ),
            const SizedBox(height: 16),
            MedicationCard(
              label: 'Data',
              date: '23/04',
              currentDose: '2',
              total: '2/8',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NovoMedicamento()),
          );
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

  const MedicationCard({
    super.key,
    required this.label,
    required this.date,
    required this.currentDose,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditMedicamento(
              label: label,
              date: date,
              currentDose: currentDose,
              total: total,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
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
