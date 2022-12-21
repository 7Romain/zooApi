package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.model.Enclos;
import fr.oz.zoo_api.model.Especes;
import fr.oz.zoo_api.service.EnclosService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EnclosController {
    @Autowired
    EnclosService enclosService;

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
}
