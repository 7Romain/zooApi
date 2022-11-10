package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import org.hibernate.annotations.Type;

import java.time.LocalDate;
import java.util.Objects;

import javax.persistence.*;



@Entity
@Getter
@Setter
@Table(name ="personnels")
@org.hibernate.annotations.TypeDef(name = "Fonction", typeClass = PostgreSQLEnumType.class)

public class Personnels {





    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_personnel")
    private Long id;

    private String nom;

    private String prenom;


    @Column(name = "secu")
    private Long secu;

    private LocalDate naissance;


    @Enumerated(EnumType.STRING)
    @Type( type ="Fonction"  )
    @Column(columnDefinition = "profession")
    private Fonction profession;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Personnels that = (Personnels) o;
        return Objects.equals(id, that.id) && Objects.equals(nom, that.nom) && Objects.equals(prenom, that.prenom) && Objects.equals(secu, that.secu) && Objects.equals(naissance, that.naissance) && profession == that.profession;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nom, prenom, secu, naissance, profession);
    }

    @Override
    public String toString() {
        return "Personnels{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", secu=" + secu +
                ", naissance=" + naissance +
                ", profession=" + profession +
                '}';
    }
}
