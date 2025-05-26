package pt.ipcb.mei.aid.agenda.controller;

import jakarta.servlet.ServletRequest;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ipcb.mei.aid.agenda.model.Agenda;
import pt.ipcb.mei.aid.agenda.model.AgendaDTO;
import pt.ipcb.mei.aid.agenda.model.AgendaMapper;
import pt.ipcb.mei.aid.agenda.service.AgendaService;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping(value = "/api")
public class AgendaController {
    private static final Logger log = LoggerFactory.getLogger(AgendaController.class);
    private final AgendaService agendaService;

    public AgendaController(AgendaService agendaService) {
        this.agendaService = agendaService;
    }

    @PostMapping
    public ResponseEntity<AgendaDTO> createAgenda(@RequestBody @Valid AgendaDTO agendaDTO) {
        try {
            Agenda agenda = new Agenda();
            agenda = AgendaMapper.fromDTO(agendaDTO);
            agenda = agendaService.save(agenda);
            return ResponseEntity.status(HttpStatus.CREATED).body(AgendaMapper.toDTO(agenda));
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping
    public ResponseEntity<AgendaDTO> updateAgenda(@RequestBody @Valid AgendaDTO agendaDTO, ServletRequest servletRequest) {
        try {
            Agenda agenda = agendaService.findById(agendaDTO.getId());

            if (agenda == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
            agenda = AgendaMapper.fromDTO(agendaDTO);
            agenda.setId(agendaDTO.getId());
            agenda = agendaService.save(agenda);
            return ResponseEntity.ok(AgendaMapper.toDTO(agenda));
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Boolean> deleteAgenda(@PathVariable Long id ) {
        try {
            Agenda agenda = agendaService.findById(id);
            if (agenda == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
            Boolean ret = agendaService.deleteById(id);
            return ResponseEntity.ok(ret);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/day/{userid}/{aaaammdd}")
    public ResponseEntity<List<AgendaDTO>> geyDay(
            @PathVariable String userid,
            @PathVariable String aaaammdd
    ) {
        try {
            LocalDate localDate = LocalDate.parse(aaaammdd, DateTimeFormatter.ISO_LOCAL_DATE);
            Long userId = Long.parseLong(userid);
            List<Agenda> agendas = agendaService.buscarEventosDoDia(userId, localDate);
            List<AgendaDTO> agendasDTO = agendas.stream().map(AgendaMapper::toDTO).toList();
            return ResponseEntity.ok(agendasDTO);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/week/{userid}/{aaaammdd}")
    public ResponseEntity<List<AgendaDTO>> geyWeek(
            @PathVariable String userid,
            @PathVariable String aaaammdd
    ) {
        try {
            LocalDate localDate = LocalDate.parse(aaaammdd, DateTimeFormatter.ISO_LOCAL_DATE);
            Long userId = Long.parseLong(userid);
            List<Agenda> agendas = agendaService.buscarEventosDaSemana(userId, localDate);
            List<AgendaDTO> agendasDTO = agendas.stream().map(AgendaMapper::toDTO).toList();
            return ResponseEntity.ok(agendasDTO);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/month/{userid}/{aaaamm}")
    public ResponseEntity<List<AgendaDTO>> getMonth(
            @PathVariable String userid,
            @PathVariable String aaaamm
    ) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
            YearMonth localAnoMes = YearMonth.parse(aaaamm, formatter);
            Long userId = Long.parseLong(userid);
            List<Agenda> agendas = agendaService.buscarEventosDoMes(userId, localAnoMes);
            List<AgendaDTO> agendasDTO = agendas.stream()
                    .map(AgendaMapper::toDTO)
                    .toList();
            return ResponseEntity.ok(agendasDTO);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


}
