package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Actions;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ActionsRepository extends CrudRepository<Actions, Long> {
}
