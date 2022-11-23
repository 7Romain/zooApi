package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Animaux;
import fr.oz.zoo_api.model.Evenements;
import fr.oz.zoo_api.model.RequeteIOAnimaux;
import fr.oz.zoo_api.service.AnimauxService;
import fr.oz.zoo_api.service.EvenementsService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;


@RestController
public class AnimauxController {

    @Autowired
    private AnimauxService animauxService;
    @Autowired
    private EvenementsService evenementsService;

    @PostMapping("/api/animaux/entrer")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'animal est à l'intérieur."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})


    public ResponseEntity<Evenements> entrerAnimal(@RequestBody RequeteIOAnimaux requeteAnimal){
        String idAnimal = requeteAnimal.getIdAnimal();

        String idEspece = animauxService.trouverEspece(idAnimal);
        System.out.println(idEspece + idAnimal);
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("entree");
        evenement.setPersonnel(requeteAnimal.getPersonne());
        evenement.setIdEspece(idEspece);
       try {

           animauxService.sortirAnimal(idAnimal);
           Evenements reponse = evenementsService.saveEvenements(evenement);
           return new ResponseEntity<>(reponse, HttpStatus.CREATED);


        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
       }
    }
    @PostMapping("/api/animaux/sortir")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'animal est à l'intérieur."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})
    public ResponseEntity<Evenements> sortirAnimal(@RequestBody RequeteIOAnimaux requeteAnimal){
        String idAnimal = requeteAnimal.getIdAnimal();

        String idEspece = animauxService.trouverEspece(idAnimal);
        System.out.println(idEspece + idAnimal);
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("entree");
        evenement.setPersonnel(requeteAnimal.getPersonne());
        evenement.setIdEspece(idEspece);
       try {

           animauxService.sortirAnimal(idAnimal);
           Evenements reponse = evenementsService.saveEvenements(evenement);
           return new ResponseEntity<>(reponse, HttpStatus.CREATED);


        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
       }
    }

    @PostMapping("/api/animaux/soigner")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'eclos a été vérifié."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})
    @PreAuthorize("hasRole('VETO')")
    public ResponseEntity<Evenements> soignerAnimal(@RequestBody Evenements evenement){
        try {
            evenement.setIdTypeEvenement("soins");
            evenement.setMoment(LocalDateTime.now());
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

}
