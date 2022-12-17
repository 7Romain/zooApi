package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Animaux;
import fr.oz.zoo_api.model.Evenements;
import fr.oz.zoo_api.model.RequeteIOAnimaux;
import fr.oz.zoo_api.service.AnimauxService;
import fr.oz.zoo_api.service.EvenementsService;
import fr.oz.zoo_api.service.PersonnelsService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
public class AnimauxController {

    @Autowired
    private AnimauxService animauxService;
    @Autowired
    private EvenementsService evenementsService;

    @Autowired
    private PersonnelsService personnelsService;

    @PostMapping("/api/animaux/entrer")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'animal est à l'intérieur."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })

    public ResponseEntity<Iterable<Animaux>> entrerAnimal(@RequestBody RequeteIOAnimaux requeteAnimal) {
        String idAnimal = requeteAnimal.getIdAnimal();

        String idEspece = animauxService.trouverEspece(idAnimal);
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("entree");
        evenement.setPersonnel(personnelsService.getPersonnelsByUsername(requeteAnimal.getUsername()));
        evenement.setIdEspece(idEspece);
        evenement.setIdAnimal(idAnimal);
        try {
           Iterable<Animaux> reponse =  animauxService.entrerAnimal(idAnimal);
             evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/animaux/sortir")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode  = "201 : Created", description = "L'animal est à l'intérieur."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Iterable<Animaux>> sortirAnimal(@RequestBody RequeteIOAnimaux requeteAnimal) {
        String idAnimal = requeteAnimal.getIdAnimal();

        String idEspece = animauxService.trouverEspece(idAnimal);
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("sortie");
        evenement.setPersonnel(personnelsService.getPersonnelsByUsername(requeteAnimal.getUsername()));
        evenement.setIdEspece(idEspece);
        evenement.setIdAnimal(idAnimal);
        try {

           Iterable<Animaux> response2 = animauxService.sortirAnimal(idAnimal);
            evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(response2, HttpStatus.CREATED);

        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/animaux/soigner")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'animal reçoit des soins."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    @PreAuthorize("hasRole('VETO')")
    public ResponseEntity<Evenements> soignerAnimal(@RequestBody RequeteIOAnimaux requeteAnimal) {
        try {
            Evenements evenement = new Evenements();
            evenement.setIdAnimal(requeteAnimal.getIdAnimal());
            evenement.setObservations(requeteAnimal.getObservations());
            evenement.setIdTypeEvenement("soins");
            evenement.setMoment(LocalDateTime.now());
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
    @GetMapping("/api/animaux")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste des animaux a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste des animaux.") })
    public ResponseEntity<List<Animaux>> listerAnimaux(){
        List<Animaux> reponse = animauxService.getAnimaux();
        if(reponse ==null)
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        return new ResponseEntity<>(reponse, HttpStatus.OK);
    }

    @GetMapping("/api/animaux/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "L'animal' a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé l'animal.") })
    public ResponseEntity<Optional<Animaux>> getAnimalById(@PathVariable("id") final String animalId){
        Optional<Animaux> reponse = animauxService.getAnimalById(animalId);
        if(reponse.isEmpty())
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        return new ResponseEntity<>(reponse, HttpStatus.OK);
    }



}
