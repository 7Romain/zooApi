package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Animaux;
import fr.oz.zoo_api.model.Enclos;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EnclosRepository extends CrudRepository<Enclos, String> {

    @Query(value = "SELECT * FROM enclos WHERE id_enclos = ?1", nativeQuery = true)
    Enclos trouverEnclosById(String idEnclos);

    @Query(value = "SELECT * FROM enclos ORDER BY nom ASC",  nativeQuery = true)
    public List<Enclos>findAllOrder();
}
