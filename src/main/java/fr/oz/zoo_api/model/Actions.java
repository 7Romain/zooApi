package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "actions")
public class Actions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_action")
    private Long id;

    @Column(name ="id_personnel")
    private Long idPersonnel;

    @Column(name ="id_enclos")
    private String idEnclos;

    @Column(name ="id_espece")
    private String idEspece;

    @Column(name ="id_animal")
    private String idAnimal;

    @Column(name ="date_prevue")
    private LocalDate datePrevue;

    private String observations;

}
