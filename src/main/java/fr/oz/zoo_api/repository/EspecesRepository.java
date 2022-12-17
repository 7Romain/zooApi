package fr.oz.zoo_api.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Especes;

@Repository
public interface EspecesRepository extends CrudRepository<Especes, String> {

    // @Query( value = "SELECT enclos FROM especes WHERE id_espece = ?1",
    // nativeQuery = true)
    // List<Enclos> trouverEnclos(String idEspece);

    @Query(value = "SELECT enclos FROM Especes specie INNER JOIN specie.enclos enclos WHERE specie.id = ?1")
    public Enclos trouverEnclos(String idEspece);

}
