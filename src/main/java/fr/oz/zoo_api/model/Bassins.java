package fr.oz.zoo_api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name = "enclos")
public class Bassins extends Enclos{


    @Column( name = "temperature_bassin_mini")
    private int temperatureBassinMini ;

    @Column( name = "temperature_bassin_maxi")
    private int temperatureBassinMaxi ;


}
