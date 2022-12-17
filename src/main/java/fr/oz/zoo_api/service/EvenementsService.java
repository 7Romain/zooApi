package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Evenements;
import fr.oz.zoo_api.repository.EvenementsRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Data
@Service
public class EvenementsService {

    @Autowired
    private EvenementsRepository evenementsRepository;

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



}
