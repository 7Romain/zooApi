package fr.oz.zoo_api.repository;

import fr.oz.zoo_api.model.Zones;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ZonesRepository extends CrudRepository<Zones,String>  {


}
