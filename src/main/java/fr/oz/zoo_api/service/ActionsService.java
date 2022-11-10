package fr.oz.zoo_api.service;

import fr.oz.zoo_api.model.Actions;
import fr.oz.zoo_api.repository.ActionsRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Data
@Service
public class ActionsService {
@Autowired
   private ActionsRepository actionsRepository;

public Actions saveActions(Actions action){
 return actionsRepository.save(action);

}



}
