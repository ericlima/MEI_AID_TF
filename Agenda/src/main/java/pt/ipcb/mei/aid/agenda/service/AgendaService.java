package pt.ipcb.mei.aid.agenda.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ipcb.mei.aid.agenda.model.Agenda;

import java.time.*;
import java.util.List;

@Service
public class AgendaService {

    private AgendaRepository agendaRepository;

    public AgendaService(AgendaRepository agendaRepository) {
        this.agendaRepository = agendaRepository;
    }

    public List<Agenda> buscarEventosDoDia(Long userId, LocalDate data) {
        LocalDateTime inicioDoDia = data.atStartOfDay();
        LocalDateTime fimDoDia = data.atTime(LocalTime.MAX);
        return agendaRepository.findByUserIdAndInicioBetween(userId, inicioDoDia, fimDoDia);
    }

    public List<Agenda> buscarEventosDaSemana(Long userId, LocalDate data) {
        LocalDate primeiroDia = data.with(DayOfWeek.MONDAY);
        LocalDate ultimoDia = data.with(DayOfWeek.SUNDAY);
        LocalDateTime inicioSemana = primeiroDia.atStartOfDay();
        LocalDateTime fimSemana = ultimoDia.atTime(LocalTime.MAX);
        return agendaRepository.findByUserIdAndInicioBetween(userId, inicioSemana, fimSemana);
    }

    public List<Agenda> buscarEventosDoMes(Long userId, YearMonth mes) {
        LocalDate primeiroDia = mes.atDay(1);
        LocalDate ultimoDia = mes.atEndOfMonth();
        LocalDateTime inicioMes = primeiroDia.atStartOfDay();
        LocalDateTime fimMes = ultimoDia.atTime(LocalTime.MAX);
        return agendaRepository.findByUserIdAndInicioBetween(userId, inicioMes, fimMes);
    }


}
