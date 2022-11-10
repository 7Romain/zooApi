package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Personnels;
import fr.oz.zoo_api.service.PersonnelsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class PersonnelsController {
    @Autowired
    private PersonnelsService personnelsService;


    @GetMapping("/api/personnels")
    public ResponseEntity<Iterable<Personnels>> getPersonnels(){
        Iterable<Personnels> reponse =  personnelsService.getPersonnels();
        if(reponse == null)
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        return new ResponseEntity<>(reponse, HttpStatus.OK);

    }

    @PostMapping("/api/personnels")
    public ResponseEntity<Personnels> creerPersonnels(@RequestBody Personnels personnels){
        try {
            Personnels reponse = personnelsService.savePersonnels(personnels);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

        }
    }
}
