package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.repository.EnclosRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Data
@Service
public class EnclosService {
    @Autowired
    private EnclosRepository enclosRepository;

    public List<Enclos>getEnclos(){
        return (List<Enclos>) enclosRepository.findAll();
    }
}
