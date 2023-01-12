package fr.oz.zoo_api.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fr.oz.zoo_api.model.Animaux;
import fr.oz.zoo_api.repository.AnimauxRepository;
import lombok.Data;

@Data
@Service
public class AnimauxService {
    @Autowired
    private AnimauxRepository animauxRepository;

    public void rentrerToutLesAnimauxSauf(String idEspece, List<String> idAnimaux) {
        animauxRepository.rentrerToutLesAnimauxSauf(idEspece, idAnimaux);
    }

    public void sortirToutLesAnimauxSauf(String idEspece, List<String> idAnimaux) {
        animauxRepository.sortirToutLesAnimauxSauf(idEspece, idAnimaux);
    }

    public void rentrerToutLesAnimaux(String idEspece) {
        animauxRepository.rentrerToutLesAnimaux(idEspece);
    }

    public void sortirToutLesAnimaux(String idEspece) {
        animauxRepository.sortirToutLesAnimaux(idEspece);
    }

    public String trouverEspece(String idAnimal) {
        return animauxRepository.trouverEspece(idAnimal);
    }

    public Iterable<Animaux> entrerAnimal(String idAnimal) {

        return animauxRepository.entrerAnimal(idAnimal);
    }

    public Iterable<Animaux> sortirAnimal(String idAnimal) {

        return animauxRepository.sortirAnimal(idAnimal);
    }


    public List<Animaux> getAnimaux() {
        return  animauxRepository.findAllOrder();
    }

    public Optional<Animaux> getAnimalById(String animalId) {
        return animauxRepository.findById(animalId) ;   }

    public Optional<List<Animaux>> getAnimauxByEspece(String especeId){
        return animauxRepository.findByEspece(especeId);
    }

    public String getNomAnimal(String animalId){
        return animauxRepository.getNomAnimal(animalId);
    }

    public Optional<List<Animaux>> getAnimauxByEnclos(String enclosId){
        return animauxRepository.findByEnclos(enclosId);
    }

}
