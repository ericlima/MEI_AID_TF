package pt.ipcb.mei.aid.user.repository;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pt.ipcb.mei.aid.user.model.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findUserByUserName(String userName);

    Optional<User> findUserByNumUtente(String numUtente);

    @Modifying
    @Transactional
    @Query("UPDATE User u SET u.pin = :pin WHERE u.id = :id")
    int updatePinById(@Param("id") Long id, @Param("pin") String pin);
}
