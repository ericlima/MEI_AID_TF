package pt.ipcb.mei.aid.agenda.model;

public class AgendaMapper {

    public static AgendaDTO toDTO(Agenda agenda) {
        AgendaDTO dto = new AgendaDTO();
        dto.setId(agenda.getId());
        dto.setUserId(agenda.getUserId());
        dto.setInicio(agenda.getInicio());
        dto.setFim(agenda.getFim());
        dto.setTitulo(agenda.getTitulo());
        dto.setLocal(agenda.getLocal());
        dto.setDiaInteiro(agenda.isDiaInteiro());
        dto.setRecorrencia_rrle(agenda.getRecorrencia_rrle());
        dto.setNotas(agenda.getNotas());
        return dto;
    }

    public static Agenda fromDTO(AgendaDTO dto) {
        Agenda agenda = new Agenda();
        agenda.setUserId(dto.getUserId());
        agenda.setInicio(dto.getInicio());
        agenda.setFim(dto.getFim());
        agenda.setTitulo(dto.getTitulo());
        agenda.setLocal(dto.getLocal());
        agenda.setDiaInteiro(dto.isDiaInteiro());
        agenda.setRecorrencia_rrle(dto.getRecorrencia_rrle());
        agenda.setNotas(dto.getNotas());
        return agenda;
    }

}
