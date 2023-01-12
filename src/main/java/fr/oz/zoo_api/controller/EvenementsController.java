package fr.oz.zoo_api.controller;

import java.time.LocalDateTime;

import fr.oz.zoo_api.model.EvenementsTypes;
import fr.oz.zoo_api.model.RequeteEvenement;
import fr.oz.zoo_api.service.EnclosService;
import fr.oz.zoo_api.service.PersonnelsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import fr.oz.zoo_api.model.Evenements;
import fr.oz.zoo_api.service.EvenementsService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@RestController
public class EvenementsController {
    @Autowired
    private EvenementsService evenementsService;

    @Autowired
    private PersonnelsService personnelsService;

    @Autowired
    private EnclosService enclosService;

    @PostMapping("/api/evenements/creer")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'evenement a bien été créé."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Evenements> creerEvenement(@RequestBody RequeteEvenement requete) {
        String observations = requete.getObservations();
        String typeEvenement = requete.getId_type_evenement();
        String personnel = requete.getId_personnel();
        Evenements evenement = new Evenements();
        if(!requete.getId_espece().isBlank()){
            String idEspece = requete.getId_espece();
            evenement.setIdEspece(idEspece);
        }
        if(!requete.getId_animal().isBlank()){
            String idAnimal = requete.getId_animal();
            evenement.setIdAnimal(idAnimal);
        }
        if (!requete.getId_enclos().isBlank()){
            String idEnclos = requete.getId_enclos();
            evenement.setEnclos(enclosService.trouverEnclosById(idEnclos));
        }




        evenement.setObservations(observations);
        evenement.setIdTypeEvenement(typeEvenement);
        evenement.setPersonnel(personnelsService.getPersonnelsByUsername(personnel).get(0));
        evenement.setMoment(LocalDateTime.now());
        try {


            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/evenements/enclos/{id}")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste d'evenements a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste d'évènements demandée") })
    public ResponseEntity<Iterable<Evenements>> getEvenementsByEnclos(@PathVariable("id") final String enclos) {
        try {
            Iterable<Evenements> reponse = evenementsService.getEvenementsByEnclos(enclos);
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/evenements")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste d'evenements a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste d'évènements demandée") })
    public ResponseEntity<Iterable<Evenements>> getEvenements() {
        try {
            Iterable<Evenements> reponse = evenementsService.getEvenements();
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/evenements/zones/{id}")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste d'evenements a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste d'évènements demandée") })
    public ResponseEntity<Iterable<Evenements>> getEvenementsByZone(@PathVariable("id") final String zone) {
        try {
            Iterable<Evenements> reponse = evenementsService.getEvenementsByZone(zone);
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/evenements/especes/{id}")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste d'evenements a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste d'évènements demandée") })
    public ResponseEntity<Iterable<Evenements>> getEvenementsByEspece(@PathVariable("id") final String espece) {
        try {
            Iterable<Evenements> reponse = evenementsService.getEvenementsByEspece(espece);
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/evenements/animaux/{id}")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste d'evenements a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste d'évènements demandée") })
    public ResponseEntity<Iterable<Evenements>> getEvenementsByAnimal(@PathVariable("id") final String animal) {
        try {
            Iterable<Evenements> reponse = evenementsService.getEvenementsByAnimal(animal);
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/api/enclos/verifier")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'eclos a été vérifié."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Evenements> verifierEnclos(@RequestBody Evenements evenement) {
        try {
            evenement.setIdTypeEvenement("verification");
            evenement.setMoment(LocalDateTime.now());
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/evenements/types")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste de type d'evenements a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste de type  d'évènements demandée") })
    public ResponseEntity<Iterable<EvenementsTypes>> getEventList() {
        try {  Iterable<EvenementsTypes> reponse =  evenementsService.getEventList();
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/evenements/types/nom/{id}")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "Le nom de l'evenement a bien été récupéré."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé le nom de l'évènement demandé") })
    public ResponseEntity<EvenementsTypes> getNomType(@PathVariable("id") final String id) {
        try {  EvenementsTypes reponse =  evenementsService.findNomById(id);
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

}
