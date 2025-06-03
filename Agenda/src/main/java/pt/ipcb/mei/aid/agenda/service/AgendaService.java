package pt.ipcb.mei.aid.agenda.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import pt.ipcb.mei.aid.agenda.model.Agenda;
import pt.ipcb.mei.aid.agenda.repository.AgendaRepository;

import java.time.*;
import java.util.List;
import java.util.Optional;

@Service
public class AgendaService {

    private static final Logger log = LoggerFactory.getLogger(AgendaService.class);

    private AgendaRepository agendaRepository;

    public AgendaService(AgendaRepository agendaRepository) {
        this.agendaRepository = agendaRepository;
    }

    public Agenda save(Agenda agenda) {
        try {
            return agendaRepository.save(agenda);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
    }

    public Agenda update(Agenda agenda) {
        Optional<Agenda> ret = agendaRepository.findById(agenda.getId());
        if (ret.isPresent()) {
            return this.save(agenda);
        }
        return null;
    }

    public Agenda findById(Long id) {
        Optional<Agenda> ret = agendaRepository.findById(id);
        return ret.orElse(null);
    }

    public boolean deleteById(Long id) {
        try {
            Optional<Agenda> ret = agendaRepository.findById(id);
            ret.ifPresent(agenda -> agendaRepository.delete(agenda));
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return false;
        }
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
