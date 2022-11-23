package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.ERole;
import fr.oz.zoo_api.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findByName(ERole name);
}