package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.*;
import fr.oz.zoo_api.service.ActionsService;
import fr.oz.zoo_api.service.EnclosService;
import fr.oz.zoo_api.service.PersonnelsService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
public class ActionsController {
    @Autowired
    private ActionsService actionsService;

    @Autowired
    private PersonnelsService personnelsService;

    @Autowired
    EnclosService enclosService;

    @PostMapping(path = "/api/actions/creer", consumes = "application/x-www-form-urlencoded")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'action est créée."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
//    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public ResponseEntity<ReponseActions> creerActions (RequeteIOAcions requeteIOAcions){

        try{

        Actions action = new Actions();
        Personnels personne = personnelsService.getPersonnelsById(requeteIOAcions.getIdPersonnel());
        action.setPersonnel(personne);
        if (!requeteIOAcions.getIdEnclos().isEmpty()) {
            Enclos enclos = enclosService.trouverEnclosById(requeteIOAcions.getIdEnclos());
            action.setEnclos(enclos);
        }
        if(!requeteIOAcions.getIdEspece().isBlank()){
            action.setIdEspece(requeteIOAcions.getIdEspece());
        }
        if(!requeteIOAcions.getIdAnimal().isBlank()){
            action.setIdAnimal(requeteIOAcions.getIdAnimal());
        }
        if(!requeteIOAcions.getObservations().isBlank()){
            action.setObservations(requeteIOAcions.getObservations());
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyy HH:mm");
        LocalDateTime dateTime = LocalDateTime.parse(requeteIOAcions.getDatePrevue(), formatter);
        action.setDatePrevue(dateTime);
Actions reponseBrut = actionsService.saveActions(action);
           ReponseActions reponse = new ReponseActions();
            reponse.setIdPersonnel(requeteIOAcions.getIdPersonnel());
            reponse.setDatePrevue(requeteIOAcions.getDatePrevue());

            if (!requeteIOAcions.getIdEnclos().isEmpty()) {
                reponse.setIdEnclos(reponseBrut.getEnclos().getId());
            }
            if(!requeteIOAcions.getIdEspece().isBlank()){
                reponse.setIdEspece(reponseBrut.getIdEspece());
            }
            if(!requeteIOAcions.getIdAnimal().isBlank()){
                reponse.setIdAnimal(reponseBrut.getIdAnimal());

            }
            if(!requeteIOAcions.getObservations().isBlank()){
                reponse.setObservations(reponseBrut.getObservations());

            }
        return new ResponseEntity<>(reponse, HttpStatus.CREATED);

        }catch(Exception e){

        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);}
    }


    @GetMapping("/api/actions/zones/{id}")
//    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public List<Actions> getActionsByZone(@PathVariable("id") final String zone){
        return actionsService.findActionsByZone(zone);
    }
    @GetMapping("/api/actions/enclos/{id}")
//    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public List<Actions> trouverActionsByEnclos(@PathVariable("id") final String enclos) {
        return actionsService.getActionsByEnclos(enclos);
    }

    @GetMapping("/api/actions/especes/{id}")
//    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public List<Actions> getActionsByEspece(@PathVariable("id") final  String espece){
        return actionsService.getActionsByEspece(espece);
    }
    @GetMapping("/api/actions/animaux/{id}")
//    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public List<Actions> getActionsByAnimal(@PathVariable("id") final  String animal){
        return actionsService.getActionsByAnimal(animal);
    }
    @GetMapping("/api/actions")
//    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public Iterable<Actions> getActions(){
        return actionsService.getActions();
    }



}
