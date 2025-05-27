package pt.ipcb.mei.aid.medicamento.controller;

import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ipcb.mei.aid.medicamento.model.Medicamento;
import pt.ipcb.mei.aid.medicamento.model.MedicamentoDTO;
import pt.ipcb.mei.aid.medicamento.model.MedicamentoMapper;
import pt.ipcb.mei.aid.medicamento.service.MedicamentoRepository;

import java.util.List;

@RestController
@RequestMapping(value = "/api")
public class MedicamentoController {

    private static final Logger log = LoggerFactory.getLogger(MedicamentoController.class);

    private final MedicamentoRepository medicamentoRepository;

    public MedicamentoController(MedicamentoRepository medicamentoRepository) {
        this.medicamentoRepository = medicamentoRepository;
    }

    @PostMapping
    public ResponseEntity<MedicamentoDTO> create(@Valid @RequestBody MedicamentoDTO medicamentoDTO) {
        try {
            Medicamento medicamento = new Medicamento();
            medicamento = MedicamentoMapper.fromDTO(medicamentoDTO);
            medicamento = medicamentoRepository.save(medicamento);
            MedicamentoDTO dto = MedicamentoMapper.toDTO(medicamento);
            return ResponseEntity.status(HttpStatus.CREATED).body(dto);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping
    public ResponseEntity<MedicamentoDTO> update(@Valid @RequestBody MedicamentoDTO medicamentoDTO) {
        try {
            Medicamento medicamento = medicamentoRepository.findById(medicamentoDTO.getId()).orElse(null);

            if (medicamento == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }

            medicamento = MedicamentoMapper.fromDTO(medicamentoDTO);
            medicamento.setId(medicamentoDTO.getId());
            medicamento = medicamentoRepository.save(medicamento);
            MedicamentoDTO dto = MedicamentoMapper.toDTO(medicamento);
            return ResponseEntity.ok(dto);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Boolean> delete(@PathVariable Long id) {
        try {
            Medicamento medicamento = medicamentoRepository.findById(id).orElse(null);

            if (medicamento == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
            }
            medicamentoRepository.delete(medicamento);
            return ResponseEntity.ok(true);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(false);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<MedicamentoDTO> findById(@PathVariable Long id) {
        try {
            Medicamento medicamento = medicamentoRepository.findById(id).orElse(null);
            if (medicamento == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
            return ResponseEntity.ok(MedicamentoMapper.toDTO(medicamento));
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<MedicamentoDTO>> getByUser(@PathVariable Long userId) {
        try {
            List<Medicamento> medicamentos = medicamentoRepository.findByUserId(userId);
            List<MedicamentoDTO> medicamentosDTO = medicamentos.stream().map(MedicamentoMapper::toDTO).toList();
            return ResponseEntity.ok(medicamentosDTO);
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

}
