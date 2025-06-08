import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'adicionar_evento.dart';
import 'alterar_evento.dart';
import 'package:meditrack/model/agenda_dto.dart'; // Certifica-te de importar o DTO correto

class CalendarioDiaPage extends StatefulWidget {
  final DateTime selectedDate;
  final List<Appointment> eventos;

  const CalendarioDiaPage({
    super.key,
    required this.selectedDate,
    required this.eventos,
  });

  @override
  State<CalendarioDiaPage> createState() => _CalendarioDiaPageState();
}

class _CalendarioDiaPageState extends State<CalendarioDiaPage> {
  late List<Appointment> eventosDoDia;

  @override
  void initState() {
    super.initState();
    _filtrarEventosDoDia();
  }

  void _filtrarEventosDoDia() {
    eventosDoDia = widget.eventos.where((appointment) {
      final data = appointment.startTime;
      return data.year == widget.selectedDate.year &&
          data.month == widget.selectedDate.month &&
          data.day == widget.selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(widget.selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: Text('Eventos em $formattedDate'),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdicionarEventoPage(date: widget.selectedDate),
            ),
          );
          setState(() => _filtrarEventosDoDia());
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: eventosDoDia.isEmpty
          ? Center(
              child: Text(
                'Nenhum evento em $formattedDate',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: eventosDoDia.length,
              itemBuilder: (context, index) {
                final evento = eventosDoDia[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: evento.color.withOpacity(0.4),
                  child: ListTile(
                    title: Text(
                      evento.subject,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Das ${DateFormat.Hm().format(evento.startTime)} '
                      'às ${DateFormat.Hm().format(evento.endTime)}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () async {
                      // Transforma Appointment em AgendaDTO (exemplo básico)
                      final dto = AgendaDTO(
                        id: evento.id as int, // cuidado: certifique-se que está vindo como int
                        userId: 0, // opcional, será ignorado ou atribuído no serviço
                        titulo: evento.subject,
                        local: evento.location ?? '',
                        inicio: evento.startTime,
                        fim: evento.endTime,
                        diaInteiro: evento.isAllDay,
                        recorrenciaRrle: null,
                        notas: evento.notes,
                      );

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AlterarEventoPage(evento: dto),
                        ),
                      );

                      setState(() => _filtrarEventosDoDia());
                    },
                  ),
                );
              },
            ),
    );
  }
}
