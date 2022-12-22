package fr.oz.zoo_api.model;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class RequeteEvenement {



   private String id_personnel;


        private Enclos id_enclos;


        private String id_espece;


        private String id_animal;


        private String id_type_evenement;

        private String observations;


}
