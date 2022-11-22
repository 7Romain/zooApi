package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.*;
import fr.oz.zoo_api.service.ActionsService;
import fr.oz.zoo_api.service.AnimauxService;
import fr.oz.zoo_api.service.EspecesService;
import fr.oz.zoo_api.service.EvenementsService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;


@RestController
public class EspecesController {

    @Autowired
    private EspecesService especesService;
    @Autowired
    private EvenementsService evenementsService;
    @Autowired
    private AnimauxService animauxService;

    @Autowired
    private ActionsService actionsService;

    @GetMapping("/api/especes")
    @ApiResponses(value = {@ApiResponse(responseCode = "200 : OK", description = "La liste des espèces a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse( responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste des espèces" )})
    public ResponseEntity<Iterable<Especes>> getEspeces(){
        try {
            Iterable<Especes> reponse = especesService.getEspeces();
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }


    }

    @PostMapping("/api/especes/rentrer")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})


    public ResponseEntity<Evenements> rentrerEspece(@RequestBody RequeteIOEspece requeteIIO){

        List<String> idAnimaux = requeteIIO.getIdAnimaux();
        Personnels personne = requeteIIO.getPersonne();
        String idEspece = requeteIIO.getIdEspece();
        Evenements evenement = new Evenements();

        if ( !idAnimaux.isEmpty() ) {
            String tableau = String.join(", ", idAnimaux);
            String exception = tableau  + " toujours dehors.";
            if (!requeteIIO.getObservations().isEmpty()) {
                exception = exception + " // " + requeteIIO.getObservations();}
            evenement.setObservations(exception);
        }else{
        if (!requeteIIO.getObservations().isEmpty()) {
            evenement.setObservations(requeteIIO.getObservations());}}
        evenement.setIdEspece(idEspece);
        evenement.setIdTypeEvenement("entree");
        evenement.setPersonnel(personne);
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        try {
            if (!idAnimaux.isEmpty()  ) {
            animauxService.rentrerToutLesAnimauxSauf(idEspece, idAnimaux);
            /*
            *création d'un évenement pour chaque animal qui est resté dehors
            *   et prévoit une action de vérification
            */
                for (String animal: idAnimaux
                     ) { Evenements evenementException = new Evenements();
                    evenementException.setPersonnel(personne);
                    evenementException.setIdEspece(animauxService.trouverEspece(animal));
                    evenementException.setIdAnimal(animal);
                    evenementException.setIdTypeEvenement("neRentrePas");
                    evenementsService.saveEvenements(evenementException);
                    Actions action = new Actions();
                    action.setPersonnel(personne);
                    action.setIdAnimal(animal);
                    action.setDatePrevue(LocalDateTime.now().plusHours(1));
                    action.setIdEspece(animauxService.trouverEspece(animal));
                    action.setObservations("Vérifier si " + animal + " est rentré");
                    String especeA = animauxService.trouverEspece(animal);
                    Enclos enclosA = especesService.trouverEnclos(especeA);
                    action.setEnclos(enclosA);
                    actionsService.saveActions(action);
                }
            }
            else {
                animauxService.rentrerToutLesAnimaux(idEspece);
            }
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
    @PostMapping("/api/especes/sortir")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})


    public ResponseEntity<Evenements> sortirEspece(@RequestBody RequeteIOEspece requeteIIO){

        List<String> idAnimaux = requeteIIO.getIdAnimaux();
        Personnels personne = requeteIIO.getPersonne();
        String idEspece = requeteIIO.getIdEspece();
        Evenements evenement = new Evenements();

            if (!idAnimaux.isEmpty()  ) {
            String tableau = String.join(", ", idAnimaux);
            String exception = tableau  + " toujours dedans.";
                if (!requeteIIO.getObservations().isEmpty()) {
                    exception = exception + " // " + requeteIIO.getObservations();}
                evenement.setObservations(exception);
            }else{
                if (!requeteIIO.getObservations().isEmpty()) {
                    evenement.setObservations(requeteIIO.getObservations());}}
        evenement.setIdTypeEvenement("sortie");
        evenement.setPersonnel(personne);
        evenement.setIdEspece(idEspece);
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        try {
            if (!idAnimaux.isEmpty() ) {
            animauxService.sortirToutLesAnimauxSauf(idEspece, idAnimaux);
                /*
                 *création d'un évenement pour chaque animal qui est resté dedans
                 * et prévoit une action de vérification
                 */
                for (String animal: idAnimaux
                ) { Evenements evenementException = new Evenements();
                    evenementException.setPersonnel(personne);
                    evenementException.setIdEspece(animauxService.trouverEspece(animal));
                    evenementException.setIdAnimal(animal);
                    evenementException.setIdTypeEvenement("neSortPas");
                    evenementsService.saveEvenements(evenementException);
                    Actions action = new Actions();
                    action.setPersonnel(personne);
                    action.setIdAnimal(animal);
                    action.setDatePrevue(LocalDateTime.now().plusHours(1));
                    action.setIdEspece(animauxService.trouverEspece(animal));
                    action.setObservations("Vérifier si " + animal + " est sortie");
                    String especeA = animauxService.trouverEspece(animal);
                    Enclos enclosA = especesService.trouverEnclos(especeA);
                    action.setEnclos(enclosA);
                    actionsService.saveActions(action);


                }
            }

            else {
                    animauxService.sortirToutLesAnimaux(idEspece);

            }
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/especes/nourrir")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})
    public ResponseEntity<Evenements> nourrirEspece(@RequestBody RequeteIOEspece requeteIOEspece){
        String idEspece = requeteIOEspece.getIdEspece();
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("nourrissage");
        evenement.setPersonnel(requeteIOEspece.getPersonne());
        evenement.setIdEspece(idEspece);
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        if (!requeteIOEspece.getObservations().isEmpty()) {
            evenement.setObservations(requeteIOEspece.getObservations());}
        try {
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);

        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
    @PostMapping("/api/especes/stimuler")
    @ApiResponses(value = {@ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse( responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide." )})
    public ResponseEntity<Evenements> stimulerEspece(@RequestBody RequeteIOEspece requeteIOEspece){
        String idEspece = requeteIOEspece.getIdEspece();
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("stimulation");
        evenement.setPersonnel(requeteIOEspece.getPersonne());
        evenement.setIdEspece(idEspece);
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        if (!requeteIOEspece.getObservations().isEmpty()) {
            evenement.setObservations(requeteIOEspece.getObservations());}
        try {
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);

        }catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }




}
