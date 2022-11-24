package fr.oz.zoo_api.service;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class EvenementsServiceTest {
@Autowired
    EvenementsService evenementsService;



    @Test
    @DisplayName("Test pour vérifié la connection à la base")
    void TestgetEvenementsByAnimal() {
        String animal = "monax";
//        int id = 40;

        Assertions.assertThat(evenementsService.getEvenementsByAnimal(animal).iterator().next().getIdAnimal()).isEqualTo(animal);


    }
}