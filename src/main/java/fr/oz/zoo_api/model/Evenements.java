package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "evenements")
public class Evenements {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_evenement")
    private Long id;

    @Column(name ="id_personnel")
    private Long idPersonnel;

    @Column(name ="id_enclos")
    private String idEnclos;

    @Column(name ="id_espece")
    private String idEspece;

    @Column(name ="id_animal")
    private String idAnimal;

    @Column(name ="id_type_evenement")
    private String idTypeEvenement;

    private String observations;

}
