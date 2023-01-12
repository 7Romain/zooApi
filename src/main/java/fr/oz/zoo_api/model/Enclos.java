package fr.oz.zoo_api.model;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;


import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "enclos")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Enclos {
    @Id
    @Column(name = "id_enclos")
    private String id;

    private String nom;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    @JoinColumn(name = "zone_geo",  nullable = false)
    private Zones zone;

    @OneToMany(mappedBy = "enclos" )
    @JsonIgnore
    @Fetch(FetchMode.JOIN)
    private List<Especes> especes;

    private Integer superficie;

    private String coordonnees;

    @Column(name = "temperature_air")
    private Integer temperatureAir;

    private Integer hygrometrie;


    @Column(name = "temperature_bassin_mini")
    private Integer temperatureBassinMini;

    @Column(name = "temperature_bassin_maxi")
    private Integer temperatureBassinMaxi;


}
