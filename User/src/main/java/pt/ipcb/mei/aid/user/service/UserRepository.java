package pt.ipcb.mei.aid.user.service;

import org.springframework.data.jpa.repository.JpaRepository;
import pt.ipcb.mei.aid.user.model.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findUserByUserName(String userName);

    Optional<User> findUserByNumUtente(String numUtente);
}
