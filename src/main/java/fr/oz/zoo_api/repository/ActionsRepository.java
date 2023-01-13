package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Actions;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
@Repository
public interface ActionsRepository extends CrudRepository<Actions, String> {


      @Query(
              value = "SELECT * FROM actions INNER JOIN enclos ON actions.id_enclos = enclos.id_enclos WHERE enclos.zone_geo = ?1" , nativeQuery = true
    )
      List<Actions> findActionsByZone(String zone);

    @Query(
            value = "SELECT * FROM actions WHERE id_enclos = ?1 ORDER BY date_prevue ASC" , nativeQuery = true
    )
      List<Actions> getActionsByEnclos(String enclos);

    @Query(
            value = "SELECT * FROM actions WHERE id_espece = ?1 ORDER BY date_prevue ASC"  , nativeQuery = true
    )
     List<Actions> getActionsByIdEspece(String espece);


    @Query(
            value = "SELECT * FROM actions WHERE id_animal = ?1 ORDER BY date_prevue ASC"  , nativeQuery = true
    )
     List<Actions> findActionsByIdAnimal(String animal);


     @Query(
             value = "SELECT * FROM actions ORDER BY date_prevue DESC" , nativeQuery = true
     )
     List<Actions> findAllAction();

}
