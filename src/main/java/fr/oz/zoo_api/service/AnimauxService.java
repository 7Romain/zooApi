package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Animaux;
import fr.oz.zoo_api.repository.AnimauxRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Data
@Service
public class AnimauxService {
    @Autowired
    private AnimauxRepository animauxRepository;

    public Iterable<Animaux> rentrerToutLesAnimauxSauf(String idEspece , List<String> idAnimaux){
        return animauxRepository.rentrerToutLesAnimauxSauf(idEspece, idAnimaux);
    }
    public Iterable<Animaux> sortirToutLesAnimauxSauf(String idEspece , List<String> idAnimaux){
        return animauxRepository.sortirToutLesAnimauxSauf(idEspece, idAnimaux);
    }
    public Iterable<Animaux> rentrerToutLesAnimaux(String idEspece){
        return animauxRepository.rentrerToutLesAnimaux(idEspece);
    }
    public Iterable<Animaux> sortirToutLesAnimaux(String idEspece){
        return animauxRepository.sortirToutLesAnimaux(idEspece);
    }

    public String trouverEspece(String idAnimal){
        return animauxRepository.trouverEspece(idAnimal);
    }

    public Iterable<Animaux> entrerAnimal(String idAnimal){
        System.out.println(idAnimal);
        return animauxRepository.entrerAnimal(idAnimal);
    }
    public Iterable<Animaux> sortirAnimal(String idAnimal){
        System.out.println(idAnimal);
        return animauxRepository.sortirAnimal(idAnimal);
    }
//    public Iterable<Animaux> nourrirEspece(String idEspece){
//        return animauxRepository.nourrirEspece(idEspece);
//    }

}
