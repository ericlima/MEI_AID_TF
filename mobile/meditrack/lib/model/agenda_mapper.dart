import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'agenda_dto.dart';

class AgendaMapper {
  /// Converte de DTO para Appointment (Syncfusion)
  static Appointment fromDTO(AgendaDTO dto) {
    return Appointment(
      id: dto.id,
      startTime: dto.inicio,
      endTime: dto.fim ?? dto.inicio.add(const Duration(hours: 1)),
      subject: dto.titulo,
      location: dto.local,
      isAllDay: dto.diaInteiro,
      notes: dto.notas,
      recurrenceRule: dto.recorrenciaRrle,
      color: Colors.blue, // ou defina com base em regra
    );
  }

  /// Converte de Appointment para DTO
  static AgendaDTO toDTO(Appointment appointment, int userId) {
    return AgendaDTO(
      id: appointment.id is int ? appointment.id as int : 0,
      userId: userId,
      inicio: appointment.startTime,
      fim: appointment.endTime,
      titulo: appointment.subject,
      local: appointment.location ?? '',
      diaInteiro: appointment.isAllDay,
      notas: appointment.notes,
      recorrenciaRrle: appointment.recurrenceRule,
    );
  }

  /// Lista de Appointment a partir de lista de DTOs
  static List<Appointment> fromDTOList(List<AgendaDTO> dtos) {
    return dtos.map(fromDTO).toList();
  }

  /// Lista de DTOs a partir de lista de Appointments
  static List<AgendaDTO> toDTOList(List<Appointment> appointments, int userId) {
    return appointments.map((a) => toDTO(a, userId)).toList();
  }
}
