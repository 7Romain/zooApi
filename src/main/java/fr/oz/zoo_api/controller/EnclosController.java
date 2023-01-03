package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Evenements;
import fr.oz.zoo_api.model.RequeteIOAnimaux;
import fr.oz.zoo_api.model.Zones;
import fr.oz.zoo_api.service.EnclosService;
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
import java.util.Optional;

@RestController
public class EnclosController {
    @Autowired
    EnclosService enclosService;

    @Autowired
    EvenementsService evenementsService;

    @Autowired
    PersonnelsService personnelsService;

    @GetMapping("api/enclos")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste des espèces a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste des espèces") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
public ResponseEntity<Iterable<Enclos>> getEnclos(){
        try {
            Iterable<Enclos> reponse = enclosService.getEnclos();
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

    }

    @PostMapping("/api/enclos/controller")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'eclos a été vérifié."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Evenements> verifierEnclos(@RequestBody RequeteIOAnimaux requete) {

        Enclos enclos = enclosService.trouverEnclosById(requete.getIdAnimal());


        try {
            Evenements evenement = new  Evenements();
            evenement.setIdTypeEvenement("verification");

                evenement.setEnclos(enclos);

            evenement.setMoment(LocalDateTime.now());
            evenement.setObservations(requete.getObservations());
            evenement.setPersonnel(personnelsService.getPersonnelsByUsername(requete.getUsername()).get(0));

            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("api/enclos/espece/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "Les especes ont bien été récupérés et sont retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé d'espece.") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public ResponseEntity <Optional<Iterable<Enclos>>>getEspeceByEspeces(@PathVariable("id") final String especeId){
        Optional<Iterable<Enclos>> reponse = enclosService.getEnclosByEspece(especeId);
        if(reponse.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(reponse, HttpStatus.OK);
    }
    @GetMapping("api/enclos/animal/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "Les especes ont bien été récupérés et sont retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé d'espece.") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public ResponseEntity <Optional<Iterable<Enclos>>>getEnclosByAnimal(@PathVariable("id") final String animalId){
        Optional<Iterable<Enclos>> reponse = enclosService.getEnclosByAnimal(animalId);
        if(reponse.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(reponse, HttpStatus.OK);
    }
    @GetMapping("api/enclos/zones")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "Les zones ont bien été récupérés et sont retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé de zone.") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
//    public ResponseEntity <Optional<Iterable<Zones>>>getZones(){
//        Optional<Iterable<Zones>> reponse = enclosService.getZones();
//        if(reponse.isEmpty()) {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//        return new ResponseEntity<>(reponse, HttpStatus.OK);
//    }
    public Iterable<Zones>getZones(){
        return enclosService.getZones();



    }

    @GetMapping("api/enclos/nom/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "Le nom a bien été récupéré ."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé le nom.") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public String getNombyId(@PathVariable("id") final String idEnclos){
        return enclosService.getNomEnclosById(idEnclos);
    }


}
