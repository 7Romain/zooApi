package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "actions")
public class Actions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_action")
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

    @Column(name ="date_prevue")
    private LocalDateTime datePrevue;

    private String observations;

    public Actions(String idEspece) {
        this.idEspece = idEspece;
    }
}
