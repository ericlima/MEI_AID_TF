import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utilizador/login_screen.dart';
import '../medicamento/medicamentos_page.dart';
import 'calendario_dia.dart';
import 'adicionar_evento.dart';

import 'funcoes_calendario.dart'; // contém obtemAgendaMes()
import '../model/agenda_dto.dart';
import '../model/agenda_mapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime _focusedDay = DateTime.now();
  MeetingDataSource? _dataSource;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarEventos();
  }

  void _abrirEventosDoDia(DateTime dia) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final eventosDoDia = await obtemAgendaDia(dia);

      Navigator.pop(context); // fecha loading

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) =>
                  CalendarioDiaPage(selectedDate: dia, eventos: eventosDoDia),
        ),
      );
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar eventos do dia: $e')),
      );
    }
  }

  Future<void> _carregarEventos() async {
    try {
      int mesAtual = DateTime.now().month;
      List<Appointment> eventos = await obtemAgendaMes(mesAtual);
      setState(() {
        _dataSource = MeetingDataSource(eventos);
        _carregando = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar agenda: $e');
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdicionarEventoPage(date: DateTime.now()),
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Calendário', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _carregando
                    ? const Center(child: CircularProgressIndicator())
                    : SfCalendar(
                      view: CalendarView.month,
                      initialDisplayDate: _focusedDay,
                      firstDayOfWeek: 1,
                      todayHighlightColor: Colors.teal,
                      showDatePickerButton: true,
                      showNavigationArrow: true,
                      dataSource: _dataSource,
                      selectionDecoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.3),
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: (CalendarTapDetails details) {
                        if (details.targetElement ==
                                CalendarElement.calendarCell &&
                            details.date != null) {
                          _abrirEventosDoDia(details.date!);
                        }
                      },
                    ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _HomeButton(
                  text: 'Medicamentos',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MedicamentosPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _HomeButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
