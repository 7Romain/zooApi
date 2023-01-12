package fr.oz.zoo_api.controller;

//@SpringBootTest

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;


import org.junit.jupiter.api.Test;

@SpringBootTest
class ActionsControllerTest {

    @Autowired
    ActionsController actionsController;



    //J'ai enlevé le test car il n'y a plus besoin d'authentification  sur l'api
    // relative aux actions car l'appli mobile n'intègre pas encore  d'authentification
//    @Test
//     void getMessageUnauthenticated() {
//        // assertThatThrownBy(()->{actionsController.getActionsByZone("montagne-europe");}).isInstanceOf(AuthenticationCredentialsNotFoundException.class);
//        assertThrows(AuthenticationCredentialsNotFoundException.class, () -> {
//            actionsController.getActionsByZone("montagne-europe");
//        });
//    }

    @Test
    void contextLoads() {
        assertThat(actionsController).isNotNull();
    }



}
