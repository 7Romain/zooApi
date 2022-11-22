package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Evenements;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
@Repository
public interface EvenementsRepository extends CrudRepository<Evenements, Long> {
List<Evenements> findByIdAnimal(String animal);

    @Query(
            value = "SELECT * FROM evenements u WHERE u.id_enclos = ?1" , nativeQuery = true
    )
    Collection<Evenements>findEvenementsByEnclos(String enclos);

    @Query(
//            value = "SELECT * FROM evenements INNER JOIN enclos ON evenements.id_enclos = enclos.id_enclos WHERE u.zone_geo = ?1" , nativeQuery = true
//            value = "SELECT DISTINCT e.id_evenement, e.id_personnel, e.id_enclos, e.id_espece, e.id_animal, e.id_type_evenement, e.observations, c.nom, c.zone_geo, c.superficie, c.coordonnees, c.temperature_bassin_mini, c.temperature_bassin_maxi, c.temperature_air, c.hygrometrie  FROM Evenements e, Enclos c WHERE c.zone_geo = ?1" , nativeQuery = true
              value = "SELECT * FROM evenements INNER JOIN enclos ON evenements.id_enclos = enclos.id_enclos WHERE enclos.zone_geo = ?1" , nativeQuery = true
    )
    List<Evenements>findEvenementsByZone(String zone);

    @Query(
//            value = "SELECT * FROM evenements INNER JOIN enclos ON evenements.id_enclos = enclos.id_enclos WHERE u.zone_geo = ?1" , nativeQuery = true
//            value = "SELECT DISTINCT e.id_evenement, e.id_personnel, e.id_enclos, e.id_espece, e.id_animal, e.id_type_evenement, e.observations, c.nom, c.zone_geo, c.superficie, c.coordonnees, c.temperature_bassin_mini, c.temperature_bassin_maxi, c.temperature_air, c.hygrometrie  FROM Evenements e, Enclos c WHERE c.zone_geo = ?1" , nativeQuery = true
            value = "SELECT * FROM evenements u WHERE u.id_espece = ?1" , nativeQuery = true
    )
    Collection<Evenements> getEvenementsByIdEspece(String espece);

}
