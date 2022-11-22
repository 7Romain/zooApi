package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Animaux;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
public interface AnimauxRepository extends CrudRepository<Animaux, String> {

    @Modifying
    @Query(
            value = "UPDATE animaux SET localisation = 'dedans' WHERE espece = :idEspece AND NOT id_animal IN (:idAnimaux) RETURNING *" , nativeQuery = true
    )
    Iterable<Animaux> rentrerToutLesAnimauxSauf(@Param("idEspece")String idEspece, @Param("idAnimaux") List<String> idAnimaux);

    @Modifying
    @Query(
            value = "UPDATE animaux SET localisation = 'dehors' WHERE espece = :idEspece AND NOT id_animal IN (:idAnimaux) RETURNING *" , nativeQuery = true
    )
    Iterable<Animaux> sortirToutLesAnimauxSauf(@Param("idEspece")String idEspece, @Param("idAnimaux") List<String> idAnimaux);
    @Modifying
    @Query(
            value = "UPDATE animaux SET localisation = 'dedans' WHERE espece = :idEspece  RETURNING *" , nativeQuery = true
    )
    Iterable<Animaux> rentrerToutLesAnimaux(@Param("idEspece")String idEspece);

    @Modifying
    @Query(
            value = "UPDATE animaux SET localisation = 'dehors' WHERE espece = :idEspece  RETURNING *" , nativeQuery = true
    )
    Iterable<Animaux> sortirToutLesAnimaux(@Param("idEspece")String idEspece);

    @Query( value = "SELECT espece FROM animaux WHERE id_animal = ?1", nativeQuery = true)
    String trouverEspece(String idAnimal);
    @Modifying
    @Query( value = "UPDATE animaux SET localisation = 'dedans' WHERE id_animal = ?1 RETURNING *" , nativeQuery = true )
    Iterable<Animaux> entrerAnimal(String idAnimal);
    @Modifying
    @Query( value = "UPDATE animaux SET localisation = 'dehors' WHERE id_animal = ?1 RETURNING *" , nativeQuery = true )
    Iterable<Animaux> sortirAnimal(String idAnimal);
//    @Modifying
//    @Query( value = "UPDATE animaux SET ?????? = 'nourri' WHERE id_espece = ?1 RETURNING *" , nativeQuery = true )
//    Iterable<Animaux> nourrirEspece(String idEspece);


}