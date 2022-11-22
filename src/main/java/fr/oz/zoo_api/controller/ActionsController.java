package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Actions;
import fr.oz.zoo_api.service.ActionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ActionsController {
    @Autowired
    private ActionsService actionsService;

    @PutMapping("/api/actions/creer")
    public Actions creerActions (@RequestBody Actions action){
        actionsService.saveActions(action);
        return action;
    }

    @GetMapping("/api/actions/zones/{id}")
    public List<Actions> getActionsByZone(@PathVariable("id") final String zone){
        return actionsService.findActionsByZone(zone);
    }
    @GetMapping("/api/actions/enclos/{id}")
    public List<Actions> trouverActionsByEnclos(@PathVariable("id") final String enclos) {
        return actionsService.getActionsByEnclos(enclos);
    }

    @GetMapping("/api/actions/especes/{id}")
    public List<Actions> getActionsByEspece(@PathVariable("id") final  String espece){
        return actionsService.getActionsByEspece(espece);
    }
    @GetMapping("/api/actions/animaux/{id}")
    public List<Actions> getActionsByAnimal(@PathVariable("id") final  String animal){
        return actionsService.getActionsByAnimal(animal);
    }


//        @GetMapping("/test/{id}")
//        public List<Actions> getActionsByZone(@PathVariable("id") final String zone){
//            return actionsService.findActionsByZone(zone);
//    }

}
