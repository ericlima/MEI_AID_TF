package pt.ipcb.mei.aid.medicamento.service;

import org.springframework.data.jpa.repository.JpaRepository;
import pt.ipcb.mei.aid.medicamento.model.Medicamento;
import pt.ipcb.mei.aid.medicamento.model.MedicamentoDTO;

import java.util.List;

public interface MedicamentoRepository extends JpaRepository<Medicamento, Long> {

    List<Medicamento> findByUserId(long userId);

}
