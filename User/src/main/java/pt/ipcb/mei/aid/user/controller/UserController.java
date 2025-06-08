package pt.ipcb.mei.aid.user.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pt.ipcb.mei.aid.user.model.*;
import pt.ipcb.mei.aid.user.repository.UserRepository;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Optional;

@RestController
@RequestMapping(value = "/api")
public class UserController {

    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    public UserController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    
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

    @DeleteMapping("/{userId}")
    public ResponseEntity<Void> delete(@PathVariable Long userId) {
        try {

            Optional<User> user = userRepository.findById(userId);

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            userRepository.deleteById(userId);

            // Retornar 200
            return ResponseEntity.ok().build();
        } catch(Exception ex) {
            log.error("Erro ao excluir user", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/novo")
    public ResponseEntity<UserDTO> createNovo(@RequestBody @Valid UserDTO userDTO) {
        return this.create(userDTO);
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
    public ResponseEntity<?> obterPorUtente(@ModelAttribute UserNameDTO userDTO, BindingResult result) {
        try {

            if (result.hasErrors()) {
                return ResponseEntity.badRequest().body(result.getAllErrors());
            }

            Optional<User> user = userRepository.findUserByNumUtente(userDTO.getNumUtente());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            return ResponseEntity.ok().body(UserMapper.toDTO(user.get()));

        } catch(Exception ex) {
            log.error("Erro ao obter um utilizador", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/pincreate")
    public ResponseEntity<?> createPin(@RequestBody AuthController.LoginRequest userDTO) {
        try {

            Optional<User> user = userRepository.findUserByUserName(userDTO.getUsername());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            //String passwordHash = passwordEncoder.encode(userDTO.getPassword());
            //User usr = user.get();

            // desabilitado para testes - o objetivo deste if e so permitir create caso
            /*if (usr.getPin() != null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
            }*/
            PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String pinHash = passwordEncoder.encode(userDTO.getPassword());

            userRepository.updatePinById(user.get().getId(), pinHash);

            return ResponseEntity.status(HttpStatus.OK).build();

        } catch (Exception ex) {
            log.error("Erro ao criar o pin", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @PutMapping("/pinupdate")
    public ResponseEntity<?> updatePin(@RequestBody SecurityDTO userDTO) {
        try {

            Optional<User> user = userRepository.findUserByUserName(userDTO.getUserName());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            /*if (user.get().getPin().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
            }*/

            // verifica o pin ja existente
            /*if (!userDTO.getPin().equals(user.get().getPin())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
            }*/

            userRepository.updatePinById(user.get().getId(), userDTO.getNewPin());

            return ResponseEntity.status(HttpStatus.OK).build();

        } catch (Exception ex) {
            log.error("Erro ao atualizar o pin", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }
    
    @GetMapping("/pincheck")
    public ResponseEntity<?> validaPin(@ModelAttribute SecurityDTO userDTO, BindingResult result) {
        try {

            Optional<User> user = userRepository.findUserByUserName(userDTO.getUserName());

            if (user.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            boolean valido = userDTO.getPin().equals(user.get().getPin());

            if (!valido) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }

            return ResponseEntity.status(HttpStatus.OK).build();

        } catch (Exception ex) {
            log.error("Erro ao atualizar o pin", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

}
