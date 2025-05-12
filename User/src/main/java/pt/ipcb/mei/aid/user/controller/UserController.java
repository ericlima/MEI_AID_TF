package pt.ipcb.mei.aid.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pt.ipcb.mei.aid.user.model.User;
import pt.ipcb.mei.aid.user.model.UserDTO;
import pt.ipcb.mei.aid.user.model.UserMapper;
import pt.ipcb.mei.aid.user.model.UserNameDTO;
import pt.ipcb.mei.aid.user.service.UserRepository;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Optional;

@RestController
@RequestMapping(value = "/users")
public class UserController {

    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserRepository userRepository;

    @PostMapping
    public ResponseEntity<UserDTO> create(@RequestBody @Valid UserDTO userDTO) {
        try {
            // Converter DTO → Entity
            User newUser = new User();

            newUser = UserMapper.fromDTO(userDTO);

            // Salvar
            User savedUser = userRepository.save(newUser);

            // Converter Entity → DTO de resposta
            UserDTO responseDTO = UserMapper.toDTO(savedUser);

            // Retornar 201 Created
            return ResponseEntity.status(HttpStatus.CREATED).body(responseDTO);

        } catch (Exception ex) {
            log.error("Erro ao criar user", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @PutMapping
    public ResponseEntity<UserDTO> update(@RequestBody @Valid UserDTO userDTO) {
        try {

            Optional<User> user = userRepository.findById(userDTO.getId());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            // Converter DTO → Entity
            User newUser = user.get();

            newUser = UserMapper.fromDTO(userDTO);

            // Salvar
            User savedUser = userRepository.save(newUser);

            // Converter Entity → DTO de resposta
            UserDTO responseDTO = UserMapper.toDTO(savedUser);

            // Retornar 200
            return ResponseEntity.status(HttpStatus.OK).body(responseDTO);
        } catch(Exception ex) {
            log.error("Erro ao atualizar user", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/username")
    public ResponseEntity<?> obterPorNome(@ModelAttribute UserNameDTO userDTO, BindingResult result) {
        try {

            if (result.hasErrors()) {
                return ResponseEntity.badRequest().body(result.getAllErrors());
            }

            Optional<User> user = userRepository.findUserByUserName(userDTO.getUserName());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            return ResponseEntity.ok().body(UserMapper.toDTO(user.get()));

        } catch(Exception ex) {
            log.error("Erro ao obter um utilizador", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/utente")
    public ResponseEntity<UserDTO> obterPorUtente(@RequestBody UserNameDTO userName) {
        try {
            Optional<User> user = userRepository.findUserByNumUtente(userName.getNumUtente());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            return ResponseEntity.ok().body(UserMapper.toDTO(user.get()));

        } catch(Exception ex) {
            log.error("Erro ao obter um utilizador", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
