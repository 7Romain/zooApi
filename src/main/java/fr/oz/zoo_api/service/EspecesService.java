package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.repository.EspecesRepository;
import fr.oz.zoo_api.model.Especes;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Data
@Service
public class EspecesService {

    @Autowired
    private EspecesRepository especesRepository;

    public Iterable<Especes> getEspeces(){
        return especesRepository.findAll();
    }

    public Enclos trouverEnclos(String idEspece){
        return especesRepository.trouverEnclos(idEspece);
    }

//    public Enclos getEnclos(String idEspece){
//        return especesRepository.findById(idEspece);
//    }


}
