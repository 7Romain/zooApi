package fr.oz.zoo_api.repository;


import fr.oz.zoo_api.model.Personnels;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PersonnelsRepository extends CrudRepository<Personnels, Long> {

//    @Modifying
//    @Query(value =  "SELECT * FROM personnels a WHERE a.username = ?1" , nativeQuery = true
//
//    )
      List<Personnels> getPersonnelsByUsername(String username);


      @Query(value =  "SELECT * FROM personnels a WHERE a.id_personnel = ?1" , nativeQuery = true)
    Personnels getPersonnelsByIdnum(Long id);
}
