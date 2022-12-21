package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Enclos;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EnclosRepository extends CrudRepository<Enclos, Long> {


}
