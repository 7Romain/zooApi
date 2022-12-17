package fr.oz.zoo_api.repository;


import fr.oz.zoo_api.model.Personnels;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PersonnelsRepository extends CrudRepository<Personnels, Long> {

//    @Modifying
//    @Query(value =  "SELECT * FROM personnels a WHERE a.username = ?1" , nativeQuery = true
//
//    )
      Personnels getPersonnelsByUsername(String username);



}
