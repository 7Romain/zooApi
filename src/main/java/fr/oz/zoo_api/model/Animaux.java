package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "animaux")
public class Animaux {
    @Id
    @Column(name = "id_animal")
    private String id;

    private String nom;

    private String espece;

    private LocalDate naissance;

    private LocalDate deces;

    private char sexe;

    private String observations;

    private String localisation;
}
