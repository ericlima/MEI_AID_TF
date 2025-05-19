import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioDiaPage extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarioDiaPage({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: Text('Eventos em $formattedDate'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Aqui poderá adicionar eventos para $formattedDate',
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
