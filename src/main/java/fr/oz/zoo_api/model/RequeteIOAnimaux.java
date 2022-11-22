package fr.oz.zoo_api.model;

import lombok.Data;

@Data
public class RequeteIOAnimaux {

    String idAnimal;
    Personnels personne;
    String  observations;
}
