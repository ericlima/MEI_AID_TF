package pt.ipcb.mei.aid.medicamento.model;

public class MedicamentoMapper {

    public static Medicamento fromDTO(MedicamentoDTO medicamentoDTO) {
        Medicamento medicamento = new Medicamento();
        medicamento.setUserId(medicamentoDTO.getUserId());
        medicamento.setDescricao(medicamentoDTO.getDescricao());
        medicamento.setPosologia(medicamentoDTO.getPosologia());
        medicamento.setPreditor(medicamentoDTO.getPreditor());
        medicamento.setLocal(medicamentoDTO.getLocal());
        medicamento.setInicio(medicamentoDTO.getInicio());
        medicamento.setFim(medicamentoDTO.getFim());
        medicamento.setPinacesso(medicamentoDTO.getPinacesso());
        medicamento.setPinopcao(medicamentoDTO.getPinopcao());
        return medicamento;
    }

    public static MedicamentoDTO toDTO(Medicamento medicamento) {
        MedicamentoDTO medicamentoDTO = new MedicamentoDTO();
        medicamentoDTO.setUserId(medicamento.getUserId());
        medicamentoDTO.setId(medicamento.getId());
        medicamentoDTO.setDescricao(medicamento.getDescricao());
        medicamentoDTO.setPosologia(medicamento.getPosologia());
        medicamentoDTO.setPreditor(medicamento.getPreditor());
        medicamentoDTO.setLocal(medicamento.getLocal());
        medicamentoDTO.setInicio(medicamento.getInicio());
        medicamentoDTO.setFim(medicamento.getFim());
        medicamentoDTO.setPinacesso(medicamento.getPinopcao());
        medicamentoDTO.setPinopcao(medicamento.getPinopcao());
        medicamentoDTO.setDatahoraCriacao(medicamento.getDatahoraCriacao());
        medicamentoDTO.setDatahoraAlteracao(medicamento.getDatahoraAlteracao());
        return medicamentoDTO;
    }
}
