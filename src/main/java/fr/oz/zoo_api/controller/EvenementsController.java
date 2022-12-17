package fr.oz.zoo_api.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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

    @PutMapping("/api/evenements/creer")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'evenement a bien été créé."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Evenements> creerEvenement(@RequestBody Evenements evenement) {
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

}
