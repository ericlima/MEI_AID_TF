package pt.ipcb.mei.aid.user.service;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import pt.ipcb.mei.aid.user.model.User;
import pt.ipcb.mei.aid.user.repository.UserRepository;

import java.util.Optional;

@Component
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public String validateUser(String username, String password) {
        Optional<User> user = userRepository.findUserByUserName(username);
        if (user.isEmpty()) {
            return null;
        }
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        String passwordHash2 = user.get().getPin();

        if (passwordEncoder.matches(password, passwordHash2)) {
            long userCode = user.get().getId();
            return String.valueOf(userCode);
        }
        return null;
    }

}
