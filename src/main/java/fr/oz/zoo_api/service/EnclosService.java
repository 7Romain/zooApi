package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Zones;
import fr.oz.zoo_api.repository.EnclosRepository;
import fr.oz.zoo_api.repository.ZonesRepository;
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

    @Autowired
    private ZonesRepository zonesRepository;

    public List<Enclos>getEnclos(){
        return enclosRepository.findAllOrder();
    }

    public Enclos trouverEnclosById(String enclosId ){return enclosRepository.trouverEnclosById(enclosId);}

    public Optional<Iterable<Enclos>> getEnclosByEspece(String especeId){
        return enclosRepository.getEnclosByEspece(especeId);
    }
    public Optional<Iterable<Enclos>> getEnclosByAnimal(String animalId){
        return enclosRepository.getEnclosByAnimal(animalId);
    }

    public Iterable<Zones> getZones(){
        return zonesRepository.findAll();
    }

    public String getNomEnclosById(String id){return enclosRepository.getNomEnclosById(id);}
}
