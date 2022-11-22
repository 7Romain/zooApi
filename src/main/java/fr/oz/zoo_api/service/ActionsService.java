package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Actions;
import fr.oz.zoo_api.repository.ActionsRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Data
@Service
public class ActionsService {
@Autowired
   private ActionsRepository actionsRepository;

public Actions saveActions(Actions action){
 return actionsRepository.save(action);
}
public List<Actions> findActionsByZone(String zone){
    return actionsRepository.findActionsByZone(zone);
}
public List<Actions> getActionsByEnclos(String enclos){
    return actionsRepository.getActionsByEnclos(enclos);
}

public List<Actions> getActionsByEspece(String espece){
    return actionsRepository.findActionsByIdEspece(espece);
}
public List<Actions> getActionsByAnimal(String animal){

    return actionsRepository.findActionsByIdAnimal(animal);
}




}
