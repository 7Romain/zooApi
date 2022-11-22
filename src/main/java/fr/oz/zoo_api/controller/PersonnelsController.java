package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Personnels;
import fr.oz.zoo_api.service.PersonnelsService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'employé a bien été créé."), @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})
    public ResponseEntity<Personnels> creerPersonnels(@RequestBody Personnels personnels){
        try {
            Personnels reponse = personnelsService.savePersonnels(personnels);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

        }
    }
}
