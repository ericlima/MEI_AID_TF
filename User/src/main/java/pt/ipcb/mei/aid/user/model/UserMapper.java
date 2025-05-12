package pt.ipcb.mei.aid.user.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class UserMapper {
    public static UserDTO toDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUserName(user.getUserName());
        dto.setNome(user.getNome());
        dto.setEmail(user.getEmail());
        dto.setTelefone(user.getTelefone());
        dto.setDataNascto(user.getDataNascto());
        dto.setNumUtente(user.getNumUtente());
        dto.setCodigoPostal(user.getCodigoPostal());
        dto.setMorada(user.getMorada());
        dto.setCidade(user.getCidade());
        dto.setPin(user.getPin());
        dto.setPin(user.getPin());
        dto.setTelefone(user.getTelefone());
        dto.setTerms(user.getTerms().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        dto.setData_criacao(user.getDatahoraCriacao());;
        dto.setData_atualizacao(user.getDatahoraAlteracao());
        return dto;
    }

    public static User fromDTO(UserDTO user) {
        User usr = new User();
        usr.setUserName(user.getUserName());
        usr.setNome(user.getNome());
        usr.setEmail(user.getEmail());
        usr.setTelefone(user.getTelefone());
        usr.setDataNascto(user.getDataNascto());
        usr.setNumUtente(user.getNumUtente());
        usr.setCodigoPostal(user.getCodigoPostal());
        usr.setMorada(user.getMorada());
        usr.setCidade(user.getCidade());
        usr.setPin(user.getPin());
        usr.setPin(user.getPin());
        usr.setTelefone(user.getTelefone());
        usr.setTerms(user.getTerms());
        return usr;

    }
}

