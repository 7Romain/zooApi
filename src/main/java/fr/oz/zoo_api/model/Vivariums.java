package fr.oz.zoo_api.model;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "enclos")
public class Vivariums extends Enclos{

    @Column( name = "temperature_air")
    private int temperatureAir;

    private int hygrometrie;

}
