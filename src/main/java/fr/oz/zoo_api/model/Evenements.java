package fr.oz.zoo_api.model;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "evenements")
    @JsonInclude(JsonInclude.Include.NON_NULL)
public class Evenements {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_evenement")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="id_personnel")
    @Fetch(FetchMode.JOIN)
    private Personnels personnel;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="id_enclos")
    @Fetch(FetchMode.JOIN)
    private Enclos enclos;

    @Column(name ="id_espece")
    private String idEspece;

    @Column(name ="id_animal")
    private String idAnimal;

    @Column(name ="id_type_evenement")
    private String idTypeEvenement;

    private String observations;

    private LocalDateTime moment;

}
