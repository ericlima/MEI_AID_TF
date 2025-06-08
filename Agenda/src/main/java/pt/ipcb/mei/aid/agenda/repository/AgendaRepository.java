package pt.ipcb.mei.aid.agenda.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pt.ipcb.mei.aid.agenda.model.Agenda;

import java.time.LocalDateTime;
import java.util.List;

public interface AgendaRepository extends JpaRepository<Agenda, Long> {

    List<Agenda> findByUserIdAndInicioBetween(Long userId, LocalDateTime inicio, LocalDateTime fin);

}
