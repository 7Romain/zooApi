package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Zones;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EnclosRepository extends CrudRepository<Enclos, String> {

    @Query(value = "SELECT * FROM enclos WHERE id_enclos = ?1", nativeQuery = true)
    Enclos trouverEnclosById(String idEnclos);

    @Query(value = "SELECT * FROM enclos ORDER BY nom ASC",  nativeQuery = true)
    public List<Enclos>findAllOrder();

    @Query(value = "SELECT * FROM enclos INNER JOIN especes ON enclos.id_enclos = especes.enclos WHERE id_espece = ?1", nativeQuery = true)
    public Optional<Iterable<Enclos>> getEnclosByEspece(String especeId);
    @Query(value = "SELECT * FROM enclos INNER JOIN especes ON enclos.id_enclos = especes.enclos INNER JOIN animaux ON especes.id_espece = animaux.espece WHERE id_animal = ?1", nativeQuery = true)
    public Optional<Iterable<Enclos>> getEnclosByAnimal(String animal);

@Query(value= "SELECT nom FROM enclos WHERE id_enclos = ?1", nativeQuery = true)
    String getNomEnclosById(String idEnclos);
}
