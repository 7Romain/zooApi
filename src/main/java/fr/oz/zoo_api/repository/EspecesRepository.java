package fr.oz.zoo_api.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Especes;

import java.util.List;
import java.util.Optional;

@Repository
public interface EspecesRepository extends CrudRepository<Especes, String> {

    @Query(value = "SELECT enclos FROM Especes specie INNER JOIN specie.enclos enclos WHERE specie.id = ?1")
    public Enclos trouverEnclos(String idEspece);

    @Query(value = "SELECT * FROM public.especes ORDER BY id_espece ASC",  nativeQuery = true)
public List<Especes>findAllOrder();

    @Query(value = "SELECT * FROM public.especes WHERE enclos =?1",  nativeQuery = true)

    public Optional<Iterable<Especes>> findEspecesByEnclos(String especeId);

    public Optional<Iterable<Especes>>findEspecesById(String id);
}
