package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Actions;
import fr.oz.zoo_api.service.ActionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ActionsController {
    @Autowired
    private ActionsService actionsService;

    @PutMapping("/api/actions/creer")
    public Actions creerActions (@RequestBody Actions action){
        actionsService.saveActions(action);
        return action;
    }


}
