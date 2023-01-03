package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Evenements;
import fr.oz.zoo_api.model.EvenementsTypes;
import fr.oz.zoo_api.repository.EvenementsRepository;
import fr.oz.zoo_api.repository.EvenementsTypesRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;


@Data
@Service
public class EvenementsService {

    @Autowired
    private EvenementsRepository evenementsRepository;

    @Autowired
    private EvenementsTypesRepository evenementsTypesRepository;

    public Evenements saveEvenements(Evenements evenement) {
        return evenementsRepository.save(evenement);
    }

    public Iterable<Evenements> getEvenementsByEnclos(String enclos){
        return evenementsRepository.findEvenementsByEnclos(enclos);
    }
    public Iterable<Evenements> getEvenements(){
        return evenementsRepository.findAll();
    }

    public Iterable<Evenements> getEvenementsByZone(String zone){
        return evenementsRepository.findEvenementsByZone(zone);
    }

    public Iterable<Evenements> getEvenementsByEspece(String espece){
        return evenementsRepository.getEvenementsByIdEspece(espece);

    }

    public Iterable<Evenements> getEvenementsByAnimal(String animal){
        return evenementsRepository.findByIdAnimal(animal);

    }

    public Iterable<EvenementsTypes> getEventList(){
        return  evenementsTypesRepository.findAllOrder();
    }

public EvenementsTypes findNomById(String id){
        return evenementsTypesRepository.findNomById(id);
}



}
