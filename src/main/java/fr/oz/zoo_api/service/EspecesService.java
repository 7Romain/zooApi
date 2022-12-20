package fr.oz.zoo_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Especes;
import fr.oz.zoo_api.repository.EspecesRepository;
import lombok.Data;

import java.util.List;

@Data
@Service
public class EspecesService {

    @Autowired
    private EspecesRepository especesRepository;



    public Iterable<Especes> getEspeces() {
        return especesRepository.findAllOrder();
    }

    public Enclos trouverEnclos(String idEspece) {
        return especesRepository.trouverEnclos(idEspece);
    }




}
