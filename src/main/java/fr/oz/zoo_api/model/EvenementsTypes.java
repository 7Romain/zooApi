package fr.oz.zoo_api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "evenements_types")
public class EvenementsTypes {
    @Id
    @Column(name="id_type_evenement")
    private String id;

    private String nom;
}
