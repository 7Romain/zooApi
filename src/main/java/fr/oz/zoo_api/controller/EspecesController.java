package fr.oz.zoo_api.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import fr.oz.zoo_api.model.*;
import fr.oz.zoo_api.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

import static java.util.stream.Collectors.toList;

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

    @Autowired
    private PersonnelsService personnelsService;

    @GetMapping("/api/especes")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "La liste des espèces a bien été récupérée et est retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé la liste des espèces") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public ResponseEntity<Iterable<Especes>> getEspeces() {
        try {
            Iterable<Especes> reponse = especesService.getEspeces();
            return new ResponseEntity<>(reponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

    }

    @PostMapping("/api/especes/rentrer")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })

    public ResponseEntity<Evenements> rentrerEspece(@RequestBody RequeteIOEspece requeteIIO) {

        String obsIo = requeteIIO.getObservations();
        List<String> tableauNom = requeteIIO.getIdAnimaux();

        List<String> idAnimaux = requeteIIO.getIdAnimaux();
        tableauNom = idAnimaux.stream()
                .map(e -> animauxService.getNomAnimal(e))
                .collect(toList());

        Personnels personne = personnelsService.getPersonnelsByUsername(requeteIIO.getUsername()).get(0) ;
        String idEspece = requeteIIO.getIdEspece();
        Evenements evenement = new Evenements();

        if (!idAnimaux.isEmpty()) {

            String tableau = String.join(", ", tableauNom );
            String exception ="Tous les "+idEspece+" sont rentrés sauf " +  tableau + " qui est (sont) toujours dehors.";
            if (!requeteIIO.getObservations().isBlank()) {
                exception = exception + " // " + obsIo;
                evenement.setObservations(exception);
            }else {
                evenement.setObservations(exception);
            }
        } else {
            if (obsIo.isBlank()) {
                evenement.setObservations("Tous les "+idEspece+" sont rentrés.");
            }else {
                evenement.setObservations("Tous les " + idEspece + " sont rentrés." + " // " + obsIo);
            }

        }
        evenement.setIdEspece(idEspece);
        evenement.setIdTypeEvenement("entree");
        evenement.setPersonnel(personne);
        evenement.setMoment(LocalDateTime.now());

        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        try {
            if (!idAnimaux.isEmpty()) {
                animauxService.rentrerToutLesAnimauxSauf(idEspece, idAnimaux);
                /*
                 * création d'un évenement pour chaque animal qui est resté dehors
                 * et prévoit une action de vérification
                 */
                for (String animal : idAnimaux) {
                    Evenements evenementException = new Evenements();
                    evenementException.setPersonnel(personne);
                    evenementException.setIdEspece(animauxService.trouverEspece(animal));
                    evenementException.setIdAnimal(animal);
                    evenementException.setEnclos(especesService.trouverEnclos(idEspece));
                    evenementException.setIdTypeEvenement("neRentrePas");
                    evenementException.setObservations("N'est pas rentré avec les autres");
                    evenementException.setMoment(LocalDateTime.now());

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
            } else {
                animauxService.rentrerToutLesAnimaux(idEspece);
            }
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/especes/sortir")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })

    public ResponseEntity<Evenements> sortirEspece(@RequestBody RequeteIOEspece requeteIIO) {

        String obsIo = requeteIIO.getObservations();


        Personnels personne = personnelsService.getPersonnelsByUsername(requeteIIO.getUsername()).get(0);
        String idEspece = requeteIIO.getIdEspece();
        List<String> tableauNom = requeteIIO.getIdAnimaux();

        List<String> idAnimaux = requeteIIO.getIdAnimaux();
        tableauNom = idAnimaux.stream()
                .map(e -> animauxService.getNomAnimal(e))
                .collect(toList());
        Evenements evenement = new Evenements();
// Si il y a une liste d'animaux qui ne sont pas sortie avec les autres
        if (!idAnimaux.isEmpty()) {

            String tableau = String.join(", ", tableauNom);
            // le message en observations sera :
            String exception ="Tous les "+idEspece+" sont sorties sauf " +  tableau + " qui est (sont) toujours dedans.";
            //si il y a en plus déjà une observation:
            if (!requeteIIO.getObservations().isBlank()) {

                exception = exception + " // " + obsIo;
                evenement.setObservations(exception);
            }else {
                evenement.setObservations(exception);
            }
            //sinon c'est qu'il n'y a pas de liste d'animaux qui ne sont pas sortie alors si
        } else {

            if (obsIo.isBlank()) {
                evenement.setObservations("Tous les "+idEspece+" sont sorties.") ;
            }else {
                evenement.setObservations("Tous les " + idEspece + " sont sorties." + " // " + obsIo);
            }

        }
        evenement.setIdTypeEvenement("sortie");
        evenement.setMoment(LocalDateTime.now());
        evenement.setPersonnel(personne);
        evenement.setIdEspece(idEspece);
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        try {
            if (!idAnimaux.isEmpty()) {
                animauxService.sortirToutLesAnimauxSauf(idEspece, idAnimaux);
                /*
                 * création d'un évenement pour chaque animal qui est resté dedans
                 * et prévoit une action de vérification
                 */
                for (String animal : idAnimaux) {
                    Evenements evenementException = new Evenements();
                    evenementException.setPersonnel(personne);
                    evenementException.setIdEspece(animauxService.trouverEspece(animal));
                    evenementException.setIdAnimal(animal);
                    evenementException.setEnclos(especesService.trouverEnclos(idEspece));
                    evenementException.setObservations("N'est pas sorti avec les autres");
                    evenementException.setIdTypeEvenement("neSortPas");
                    evenementException.setMoment(LocalDateTime.now());
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
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/especes/nourrir")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Evenements> nourrirEspece(@RequestBody RequeteIOEspece requeteIOEspece) {

        String idEspece = requeteIOEspece.getIdEspece();
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("nourrissage");
        evenement.setIdEspece(idEspece);
        evenement.setPersonnel(personnelsService.getPersonnelsByUsername(requeteIOEspece.getUsername()).get(0));
        evenement.setMoment(LocalDateTime.now());
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        if (!requeteIOEspece.getObservations().isEmpty()) {
            evenement.setObservations(requeteIOEspece.getObservations());
        }
        try {
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);

        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/especes/stimuler")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'especes est à l'intérieur."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    public ResponseEntity<Evenements> stimulerEspece(@RequestBody RequeteIOEspece requeteIOEspece) {
        String idEspece = requeteIOEspece.getIdEspece();
        Evenements evenement = new Evenements();
        evenement.setIdTypeEvenement("stimulation");
        evenement.setPersonnel(personnelsService.getPersonnelsByUsername(requeteIOEspece.getUsername()).get(0));
        evenement.setMoment(LocalDateTime.now());
        evenement.setIdEspece(idEspece);
        evenement.setEnclos(especesService.trouverEnclos(idEspece));
        if (!requeteIOEspece.getObservations().isEmpty()) {
            evenement.setObservations(requeteIOEspece.getObservations());
        }
        try {
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);

        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/api/especes/soigner")
    @ApiResponses(value = { @ApiResponse(responseCode = "201 : Created", description = "L'espece reçoit des soins."),
            @ApiResponse(responseCode = "400 : Bad Request", description = "La syntaxe ou le contenu est invalide.") })
    @PreAuthorize("hasRole('VETO')")
    public ResponseEntity<Evenements> soignerEspece(@RequestBody RequeteIOEspece requeteIOEspece) {
        try {
            Evenements evenement = new Evenements();
            String idEspece = requeteIOEspece.getIdEspece();
            evenement.setIdEspece(idEspece);
            evenement.setObservations(requeteIOEspece.getObservations());
            evenement.setIdTypeEvenement("soins");
            evenement.setMoment(LocalDateTime.now());
            evenement.setEnclos(especesService.trouverEnclos(idEspece));
            evenement.setPersonnel(personnelsService.getPersonnelsByUsername(requeteIOEspece.getUsername()).get(0));
            Evenements reponse = evenementsService.saveEvenements(evenement);
            return new ResponseEntity<>(reponse, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("api/especes/enclos/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "Les animaux ont bien été récupérés et sont retransmise dans le corps du message."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé d'animaux.") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public ResponseEntity <Optional<Iterable<Especes>>>getEspeceByEnclos(@PathVariable("id") final String enclosId){
        Optional<Iterable<Especes>> reponse = especesService.getEspecesByEnclos(enclosId);
        if(reponse.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(reponse, HttpStatus.OK);
    }

    @GetMapping("api/espece/animaux/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200 : OK", description = "L'espece a bien  été récupérée ."),
            @ApiResponse(responseCode = "404 : Not Found", description = "Le serveur n'a pas trouvé l'espece ou l'animal .") })
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public ResponseEntity <Optional<Iterable<Especes>>>getEspeceByAnimal(@PathVariable("id") final String animalId){
        String espece = animauxService.trouverEspece(animalId);


        Optional<Iterable<Especes>> reponse = especesService.getEspecesByEspecesId(espece);
        if(reponse.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(reponse, HttpStatus.OK);
    }
}
