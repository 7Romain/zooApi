package fr.oz.zoo_api.repository;
import fr.oz.zoo_api.model.EvenementsTypes;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface EvenementsTypesRepository extends CrudRepository<EvenementsTypes, String>{

    @Query(value = "SELECT * FROM evenements_types ORDER BY id_type_evenement ASC",  nativeQuery = true)
     Iterable<EvenementsTypes> findAllOrder();

    @Query(value = "SELECT * FROM evenements_types WHERE id_type_evenement = ?1" , nativeQuery = true )
     EvenementsTypes findNomById(String id);

}

