package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "especes")
public class Especes {
    @Id
    @Column(name ="id_espece")
    private String id;

    private String nom;

    private Boolean sociable;

    private String observations;

    private Boolean dangereux;

    private String enclos;

}
