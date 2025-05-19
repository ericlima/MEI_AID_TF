import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'login_screen.dart'; // <- substitua pelo caminho correto se necessário

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarView _calendarView = CalendarView.month;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
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
          _buildViewSelector(),
          Expanded(
            child: SfCalendar(
              view: _calendarView,
              initialDisplayDate: _focusedDay,
              onViewChanged: (details) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _focusedDay = details.visibleDates.first;
                  });
                });
              },
              firstDayOfWeek: 1,
              todayHighlightColor: Colors.teal,
              showDatePickerButton: true,
              showNavigationArrow: true,
              dataSource: _getDataSource(),
              selectionDecoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.3),
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(8),
              ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Navegar para Medicamentos'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _HomeButton(
                  text: 'Análises e Consultas',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navegar para Consultas')),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _calendarButton('Dia', CalendarView.day),
          _calendarButton('Semana', CalendarView.week),
          _calendarButton('Mês', CalendarView.month),
        ],
      ),
    );
  }

  Widget _calendarButton(String label, CalendarView view) {
    final isSelected = _calendarView == view;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _calendarView = view;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.grey[800],
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }

  MeetingDataSource _getDataSource() {
    final List<Appointment> appointments = [
      Appointment(
        startTime: DateTime.now().add(const Duration(hours: 2)),
        endTime: DateTime.now().add(const Duration(hours: 3)),
        subject: 'Consulta médica',
        color: Colors.teal,
      ),
      Appointment(
        startTime: DateTime.now().add(const Duration(days: 1, hours: 4)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 5)),
        subject: 'Análise de sangue',
        color: Colors.orange,
      ),
    ];
    return MeetingDataSource(appointments);
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
