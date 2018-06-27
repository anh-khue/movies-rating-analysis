package io.anhkhue.more.repositories;

import io.anhkhue.more.models.dto.Account;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AccountRepository extends JpaRepository<Account, String> {

    Optional<Account> findByUsernameAndPassword(String username, String password);
}
