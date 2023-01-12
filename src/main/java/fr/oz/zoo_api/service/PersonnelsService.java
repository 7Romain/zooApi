package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Personnels;
import fr.oz.zoo_api.repository.PersonnelsRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Data
@Service
public class PersonnelsService {
    @Autowired
    private PersonnelsRepository personnelsRepository;

    public Iterable<Personnels> getPersonnels(){
        return personnelsRepository.findAll();
    }


    public Personnels savePersonnels(Personnels personnels){
    return personnelsRepository.save(personnels);}

    public List<Personnels> getPersonnelsByUsername(String username){
        return personnelsRepository.getPersonnelsByUsername(username);
    }

    public Personnels getPersonnelsById(long id){
        return personnelsRepository.getPersonnelsByIdnum(id);
    }

}
