package fr.oz.zoo_api.repository;


import fr.oz.zoo_api.model.Personnels;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonnelsRepository extends CrudRepository<Personnels, Long> {
}
