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
        dto.setTelefone(user.getTelefone());
        dto.setTerms(user.getTerms().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        dto.setData_criacao(user.getDatahoraCriacao());;
        dto.setData_atualizacao(user.getDatahoraAlteracao());
        dto.setGenero(user.getGenero());
        return dto;
    }

    public static User fromDTO(UserDTO userDTO) {
        User user = new User();
        user.setUserName(userDTO.getUserName());
        user.setNome(userDTO.getNome());
        user.setEmail(userDTO.getEmail());
        user.setTelefone(userDTO.getTelefone());
        user.setDataNascto(userDTO.getDataNascto());
        user.setNumUtente(userDTO.getNumUtente());
        user.setCodigoPostal(userDTO.getCodigoPostal());
        user.setMorada(userDTO.getMorada());
        user.setCidade(userDTO.getCidade());
        user.setPin(userDTO.getPin());
        user.setTelefone(userDTO.getTelefone());
        user.setTerms(userDTO.getTerms());
        user.setGenero(userDTO.getGenero());
        return user;

    }
}

