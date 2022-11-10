package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "enclos")
public class Enclos {
    @Id
    @Column(name = "id_enclos")
    private String id;

    private String nom;

    @Column(name = "zone_geo")
    private String zone;

    private int superficie;

    private String coordonnees;


}
