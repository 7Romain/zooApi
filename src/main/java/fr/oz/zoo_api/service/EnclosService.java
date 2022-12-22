package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.repository.EnclosRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Data
@Service
public class EnclosService {
    @Autowired
    private EnclosRepository enclosRepository;

    public List<Enclos>getEnclos(){
        return (List<Enclos>) enclosRepository.findAllOrder();
    }

    public Enclos trouverEnclosById(String enclosId ){return enclosRepository.trouverEnclosById(enclosId);}
}
