package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

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

    @ManyToOne
    @JoinColumn(name = "enclos")
    @Fetch(FetchMode.JOIN)
    private Enclos enclos;

}
