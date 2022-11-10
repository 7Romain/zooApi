package fr.oz.zoo_api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name = "zones")
public class Zones {
    @Id
    @Column(name = "id_zone")
    private String id;

    private String nom;


}
